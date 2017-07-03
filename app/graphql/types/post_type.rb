Types::PostType = GraphQL::ObjectType.define do
  name "Post"
  description "A short post of content with a title, may be draft or published."
  field :id, types.ID do
    description "internal ID"
  end
  field :title, types.String do
    description "title of the post"
  end
  field :body, types.String do
    description "the post content"
  end
  field :published, types.Boolean do
    description "true if the post has been published"
  end
  field :published_at, types.String do
    description "the date the post was published"
  end
  field :created_at, types.String do
    description "date the post entry was created"
  end
  field :updated_at, types.String do
    description "date the post entry was last updated"
  end

end
