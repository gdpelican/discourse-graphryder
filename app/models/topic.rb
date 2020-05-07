module Graphryder
  class Topic < Base
    include Graphryder::Model

    def create(topics)
      super(topics)

      topics.each do |topic|
        create_relationship(
          source: topic,
          target: topic.category,
          name: :member_of
        )
        create_relationship(
          source: topic,
          target: topic.user,
          name: :authored_by
        )
      end
    end

    def serialize(topic)
      topic.as_json(except: [:excerpt, :title])
    end
  end
end
