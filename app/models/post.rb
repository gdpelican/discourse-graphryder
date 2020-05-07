module Graphryder
  class Post < Base
    include Graphryder::Model

    def create(posts)
      super(posts)

      posts.each do |post|
        create_relationship(
          source: post,
          target: post.topic,
          name: :content_of
        )
        create_relationship(
          source: post,
          target: post.user,
          name: :authored_by
        )
      end
    end

    private

    def serialize(post)
      post.as_json(except: [:raw, :cooked])
    end
  end
end
