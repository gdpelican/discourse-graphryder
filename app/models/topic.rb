module Graphryder
  class Topic < Base
    prepend Graphryder::HasAuthor
    include Graphryder::Model
  end
end
