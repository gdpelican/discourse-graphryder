module Graphryder
  class Query
    include Singleton

    def perform(query)
      deserialize Discourse.redis.call(
        'GRAPH.QUERY',
        :graphryder,
        query.gsub("\n", '').squeeze(' ')
      )
    end

    private

    def deserialize(nodes)
      nodes.second
           .map(&:first)
           .map(&:to_h)
           .map { |node| node['properties'] = node['properties'].to_h; node }
    end
  end
end
