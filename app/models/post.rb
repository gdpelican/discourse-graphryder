module Graphryder
  class Post < Base
    prepend Graphryder::HasAuthor
    include Graphryder::Model

    private

    def serialize(post)
      post.as_json(except: [:raw, :cooked])
    end
  end
end
