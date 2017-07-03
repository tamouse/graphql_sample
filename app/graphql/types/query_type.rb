Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :post, Types::PostType do
    argument :id, !types.ID
    description "find a post by id"
    resolve ->(obj, args, ctx) { Post.find_by(id: args["id"]) }
  end

  field :posts, Types::PostsType do
    description "collection of posts"
    resolve ->(obj, args, ctx) { Post.select(:id, :title, :published) }
  end

end
