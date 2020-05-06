module Graphryder
  module Relationship
    def create(model)
      create_relationship(
        source: source_for(model),
        target: target_for(model),
        name: relationship_name,
        direction: direction
      )
    end

    def source_for(model)
      raise NotImplementedError.new
    end

    def target_for(model)
      raise NotImplementedError.new
    end

    def relationship_name
      raise NotImplementedError.new
    end

    def direction
      :parent
    end
  end
end
