Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  field :account, Types::AccountType do
    argument :id, !types.Int
    description "retrieve posts"
    resolve ->(obj, args, ctx) { Account.find_by(id: args[:id])}
  end
  field :post, Types::PostType do
    argument :id, !types.Int
    description "retrieve a post"
    resolve ->(obj, args, ctx) { Post.find_by(id: args[:id])}
  end

end
