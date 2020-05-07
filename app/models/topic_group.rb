module Graphryder
  class TopicGroup < Base
    include Graphryder::Relationship

    def source_for(model)
      model.topic
    end

    def target_for(model)
      model.group
    end

    def relationship_name
      :member_of
    end
  end
end
