module Resolvers
  class PostsResolver
    def call(_, args, ctx)
      posts = ::Post.all
      if args[:id]
        posts = posts.where(id: args[:id])
      elsif args[:ids]
        posts = posts.where(id: args[:ids].split(','))
      end
      posts
    end
  end
end
