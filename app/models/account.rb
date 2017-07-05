class Account < ActiveRecord::Base
  has_many :posts
end
