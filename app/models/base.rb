module Graphryder
  class Base
    include Singleton

    def graph_name
      self.class.to_s.demodulize.downcase
    end

    private

    def query(query)
      Discourse.redis.call('GRAPH.QUERY', :graphryder, query)
    end

    def create_relationship(source:, target:, name:, direction: :parent)
      alias_name = target.class.to_s.downcase
      relation = case direction
      when :parent then "-[:#{name}]->"
      when :child  then "<-[:#{name}]-"
      when :peer   then "-[:#{name}]-"
      end

      query([
        "MATCH (#{alias_name}:#{"Graphryder::#{target.class}".constantize.instance.graph_name})",
        "WHERE #{alias_name}.id = \"#{target.id}\"",
        "CREATE (#{alias_name})#{relation}(#{graph_name} {id: \"#{source.id}\"})",
      ].join(' '))
    end
  end
end
