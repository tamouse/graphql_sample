require 'rails_helper'

RSpec.describe Account, type: :model do
  it "can have many posts" do
    account = FactoryGirl.create(:account)
    expect(account.posts.count).to eq(0)
    account.posts = FactoryGirl.create_list(:post, 3, account: account)
    account.save!
    expect(account.posts.count).to eq(3)
  end

end
