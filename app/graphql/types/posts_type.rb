Types::PostsType = GraphQL::ObjectType.define do
  name "Posts"
  description "collection of posts"

  field :post, Types::PostType

end
