module Graphryder
  module Initializer
    def self.initialize!
      path = File.expand_path File.dirname(__dir__)
      Discourse.redis.call(
        'module',
        'load',
        "#{path}/discourse-graphryder/redisgraph.so"
      ) unless Discourse.redis.call('module', 'list').find { |_, name, _, _| name == 'graph' }

      Updater.initialize!
      Importer.initialize! if ENV['GRAPHRYDER_IMPORT']
    end
  end
end
