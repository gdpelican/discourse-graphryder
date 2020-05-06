module Graphryder
  class TopicTag < Base
    include Graphryder::Relationship

    def source_for(model)
      model.topic
    end

    def target_for(model)
      model.tag
    end

    def relationship_name
      :tagged_with
    end
  end
end
