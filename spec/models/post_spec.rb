require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @account = FactoryGirl.create(:account)
  end

  after(:all) do
    @account.posts.destroy_all
    @account.destroy
  end

  describe 'validations' do
    it "fails validation with no title" do
      post = Post.new
      expect(post).not_to be_valid
      expect(post.errors.full_messages).to include(/Title can't be blank/)
    end

    it "fails validation with no body" do
      post = Post.new
      expect(post).not_to be_valid
      expect(post.errors.full_messages).to include(/Body can't be blank/)
    end

    it "fails validation with no account" do
      post = Post.new
      expect(post).not_to be_valid
      expect(post.errors.full_messages).to include(/Account can't be blank/)
    end
  end


  describe "publishing" do
    let(:draft) { @account.posts.create(FactoryGirl.attributes_for(:post))}
    it "can create a draft post" do
      expect(draft).to be_valid
    end
    it "can publish a draft" do
      draft.publish!
      draft.reload
      expect(draft).to be_published
    end
  end

  describe "scopes" do
    before(:all) {
      FactoryGirl.create_list(:post, 10, account: @account)
      FactoryGirl.create_list(:published_post, 30, account: @account)
    }

    context "published posts" do
      let(:published_posts) {Post.published}
      it "returns correct number of published posts" do
        expect(published_posts.count).to eq(30)
      end
      it "returns only published posts" do
        expect(published_posts.all? {|x| x.published }).to be_truthy
      end
    end

    context "draft posts" do
      let(:draft_posts) { Post.drafts }
      it "returns correct number of draft posts" do
        expect(draft_posts.count).to eq(10)
      end
      it "returns only unpublished posts" do
        expect(draft_posts.all? {|x| !x.published }).to be_truthy
      end
    end
  end
end
