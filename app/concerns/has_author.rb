module Graphryder
  module HasAuthor
    def create(model)
      super(model)

      create_relationship(source: model, target: model.user, name: :authored_by)
    end

    def count_by_author(user_id)
      deserialize_count query(
        "MATCH (:#{graph_name})<-[:authored_by]-(:user {id: \"#{user_id}\"}) RETURN count(*) AS #{graph_name}_count"
      )
    end
  end
end
