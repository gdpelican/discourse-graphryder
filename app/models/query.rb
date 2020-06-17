module Graphryder
  class Query
    include Singleton

    def perform(query)
      deserialize Discourse.redis.call(
        'GRAPH.QUERY',
        :graphryder,
        query.gsub("\n", '').squeeze(' ')
      )
    rescue Exception => e
      warn [
        "\e[31mFailed to perform Redisgraph query:",
        "#{query}\n",
        "\e[33m#{e.message}\e[0m",
      ].join("\n")
    end

    private

    def deserialize(nodes)
      nodes.first.each_with_index.reduce({}) do |result, (key, index)|
        result.merge key => nodes.second
          .map { |v| v[index] }
          .map { |record| record.respond_to?(:to_h) ? record.to_h['properties'].to_h : record }
      end if nodes.length > 1
    end
  end
end
