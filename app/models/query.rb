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
        result.merge key => nodes.second.map { |v| v[index] }
      end if nodes.length > 1
    end
  end
end
