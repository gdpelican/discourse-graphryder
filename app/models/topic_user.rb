module Graphryder
  class TopicUser < Base
    include Graphryder::Relationship

    def source_for(model)
      model.topic
    end

    def target_for(model)
      model.user
    end

    def relationship_name
      :member_of
    end
  end
end
