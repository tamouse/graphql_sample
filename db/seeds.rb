# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl_rails'

if Rails.env.development?
  if Account.count == 0

    ac = FactoryGirl.create(:account)
    ac.posts << FactoryGirl.create_list(:post, rand(3)+1, account: ac)
    ac.posts << FactoryGirl.create_list(:published_post, rand(15)+1, account: ac)

  end
end
