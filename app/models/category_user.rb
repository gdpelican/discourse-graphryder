module Graphryder
  class CategoryUser < Base
    include Graphryder::Relationship

    def source_for(model)
      model.category
    end

    def target_for(model)
      model.user
    end

    def relationship_name
      :member_of
    end
  end
end
