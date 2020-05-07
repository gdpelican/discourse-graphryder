module Graphryder
  class Importer
    def self.import!
      import_class(::User)
      import_class(::Group)
      import_class(::Category)
      import_class(::Tag)
      import_class(::Topic) { |klass| klass.includes(:first_post) }
      import_class(::Post) { |klass| klass.where.not(post_number: 1) }

      import_class(::TopicGroup)
      import_class(::TopicTag)
      import_class(::TopicUser)

      import_class(::GroupUser)
      import_class(::CategoryUser)
    end

    def self.import_class(klass)
      models = block_given? ? yield(klass) : klass.all
      puts "Importing #{models.count} #{klass.to_s.pluralize}..."
      "Graphryder::#{klass}".constantize.instance.create(models)
    end
  end
end
