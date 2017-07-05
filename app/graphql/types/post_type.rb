Types::PostType = GraphQL::ObjectType.define do
  name "Post"
  description "A short post of content with a title, may be draft or published."
  field :id, types.Int, "internal ID"
  field :account, Types::AccountType
  field :title, types.String, "title of the post"
  field :body, types.String,  "the post content"
  field :published, types.Boolean,  "true if the post has been published"
  field :published_at, types.String,  "the date the post was published"
  field :created_at, types.String,  "date the post entry was created"
  field :updated_at, types.String,  "date the post entry was last updated"
end
