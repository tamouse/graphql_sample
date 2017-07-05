Types::AccountType = GraphQL::ObjectType.define do
  name "Account"
  field :id, types.Int, "database internal ID"
  field :name, types.String, "Account name"
  field :posts, types[Types::PostType], "Account's posts"
end
