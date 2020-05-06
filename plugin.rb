# name: discourse-graphryder
# about: RedisGraph integration for Discourse
# version: 0.1.0
# authors: James Kiesel (gdpelican)
# url: https://github.com/gdpelican/discourse-graphryder

after_initialize do
  module ::Graphryder
    class Engine < ::Rails::Engine
      engine_name 'graphryder'
      isolate_namespace Graphryder

      def self.require_path(path)
        require Rails.root.join('plugins', 'discourse-graphryder', 'app', path).to_s
      end

      path = File.expand_path File.dirname(__dir__)
      Discourse.redis.call(
        'module',
        'load',
        "#{path}/discourse-graphryder/redisgraph.so"
      ) unless Discourse.redis.call('module', 'list').find { |_, name, _, _| name == 'graph' }

      require_path 'concerns/model'
      require_path 'concerns/relationship'

      require_path 'models/base'
      require_path 'models/post'
      require_path 'models/tag'
      require_path 'models/topic'
      require_path 'models/topic_tag'
      require_path 'models/user'

      require_path 'controllers/base_controller'
      require_path 'controllers/posts_controller'
      require_path 'controllers/tags_controller'
      require_path 'controllers/topics_controller'
      require_path 'controllers/users_controller'

      require_path 'services/importer'
    end
  end

  Discourse::Application.routes.append do
    mount ::Graphryder::Engine, at: '/graphryder', as: :graphryder
  end
end
