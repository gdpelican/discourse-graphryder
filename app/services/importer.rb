module Graphryder
  class Importer
    def self.import!
      users = ::User.all
      puts "Importing #{users.count} users..."
      Graphryder::User.instance.create(users)

      tags = ::Tag.all
      puts "Importing #{tags.count} tags..."
      Graphryder::Tag.instance.create(tags)

      topics = ::Topic.includes(:first_post)
      puts "Importing #{topics.count} topics..."
      Graphryder::Topic.instance.create(topics)

      topic_tags = ::TopicTag.all
      puts "Importing #{topic_tags} topic tags..."
      Graphryder::TopicTag.instance.create(topic_tags)

      posts = ::Post.where.not(post_number: 1)
      puts "Importing #{posts.count} posts..."
      Graphryder::Post.instance.create(posts)
    end
  end
end
