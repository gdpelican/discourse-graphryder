module Graphryder
  class Query
    include Singleton

    def perform(query)
      deserialize Discourse.redis.call('GRAPH.QUERY', :graphryder, query)
    end

    def create(models)
      nodes = Array(models).map(&method(:node_for))
      query("CREATE #{nodes.join(',')}")
    end

    private

    def node_for(model)
      node = serialize(model).to_a.map { |k,v| "#{k}: '#{v}'" }.join(', ')
      "(:#{model.class.to_s.demodulize.downcase} {#{node}})"
    end

    def serialize(model)
      model.as_json
    end

    def deserialize(nodes)
      nodes.second
           .map(&:first)
           .map(&:to_h)
           .map { |node| node['properties'] = node['properties'].to_h; node }
    end
  end
end
