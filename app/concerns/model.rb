module Graphryder
  module Model
    def create(models)
      nodes = Array(models).map(&method(:node_for))
      binding.pry if graph_name == 'topic'
      query("CREATE #{nodes.join(',')}")
    end

    def all
      deserialize query(
        "MATCH (#{graph_name.pluralize}:#{graph_name}) RETURN #{graph_name.pluralize}"
      )
    end

    def count
      deserialize_count query(
        "MATCH (:#{graph_name}) RETURN count(*) AS #{graph_name}_count")
    end

    def fetch(id)
      deserialize query(
        "MATCH (#{graph_name.pluralize}:#{graph_name} {id: \"#{id}\"}) RETURN #{graph_name.pluralize}"
      )
    end

    private

    def node_for(model)
      node = serialize(model).to_a.map { |k,v| "#{k}: '#{v}'" }.join(', ')
      "(:#{graph_name} {#{node}})"
    end

    def serialize(model)
      model.as_json
    end

    def deserialize_count(count)
      count.second.first.first
    end

    def deserialize(nodes)
      nodes.second
           .map(&:first)
           .map(&:to_h)
           .map { |node| node['properties'] = node['properties'].to_h; node }
    end
  end
end
