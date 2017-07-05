require "rails_helper"

RSpec.describe Types::QueryType do

  let(:context) { {} }
  let(:variables) { {} }
  let(:result) { ::GraphqlSampleSchema.execute(
      query_string,
      context: context,
      variables: variables
      )}

  describe "account queries" do
    let(:account) { FactoryGirl.create(:account) }
    context "query string with account id" do
      let(:query_string) { %Q|{ account(id: #{account.id}) { name }}|}
      it "has a data entry" do
        expect(result).to have_key("data"), result.inspect
      end
      it "has an account entry" do
        expect(result["data"]).to have_key("account"), result.inspect
      end
      it "has a name entry" do
        expect(result["data"]["account"]).to have_key("name"), result.inspect
      end
      it "has the correct name" do
        expect(result["data"]["account"]["name"]).to eq(account.name), result.inspect
      end
    end

    context "query string missing account id" do
      let(:query_string) { %Q|{ account { name }}| }
      it "does not return a data block" do
        expect(result).not_to have_key("data"), result.inspect
      end
      it "returns an error block" do
        expect(result).to have_key("errors"), result.inspect
      end
      it "returns a single error message" do
        expect(result["errors"].count).to eq(1), result.inspect
      end

      it "return a message in the error block" do
        expect(result["errors"].first).to have_key("message"), result.inspect
      end
      it "returns the message about missing the id field" do
        expect(result["errors"].first["message"])
          .to match(/Field 'account' is missing required arguments: id/), result.inspect
      end
    end

    context "account with posts" do
      before { account.posts = FactoryGirl.create_list(:post, 3, account: account) +
        FactoryGirl.create_list(:published_post, 10, account: account)}
      let(:query_string) { %Q| { account(id: #{account.id}) {name posts { title published }}}| }
      it "returns data" do
        expect(result).to have_key("data"), result.inspect
      end
      it "returns a collection of posts" do
        expect(result["data"]["account"]).to have_key("posts"), result.inspect
      end
      it "returns 13 posts" do
        expect(result["data"]["account"]["posts"].count).to eq(13), result.inspect
      end
      it "returns only the title and published keys" do
        expect(result["data"]["account"]["posts"].all? {|x| x.keys == %w[title published]}).to be_truthy, result.inspect
      end

    end
  end

  describe "post queries" do
    let(:post) { FactoryGirl.create(:post)}
    context "query string with a post id" do
      let(:query_string) { %Q|{post(id: #{post.id}) {title} }| }
      it "returns a data block" do
        expect(result).to have_key("data"), result.inspect
      end
      it "returns a post" do
        expect(result.dig("data").keys).to eq(%w[post]), result.inspect
      end
      it "returns the post title" do
        expect(result.dig("data", "post").keys).to eq(%w[title]), result.inspect
      end
      it "returns the proper title" do
        expect(result.dig("data", "post", "title")).to eq(post.title), result.inspect
      end
    end

    context "query string without a post id" do
      let(:query_string) { %Q|{post {title}}| }
      it "returns an errors block" do
        expect(result.keys).to eq(%w[errors]), result.inspect
      end
      it "returns a collection of errors" do
        expect(result.dig("errors")).to be_an(Array), result.inspect
      end
      it "returns one error" do
        expect(result.dig("errors").count).to eq(1), result.inspect
      end
      it "returns the expected error message about a missing id" do
        expect(result.dig("errors").first.dig("message"))
          .to match(/\AField 'post' is missing required arguments: id\z/), result.inspect
      end
    end

    context "query string with account" do
      let(:query_string) { %Q|{ post(id: #{post.id}) {title published body account { name id }}}| }
      it "returns a data block" do
        expect(result.keys).to eq(%w[data]), result.inspect
      end
      it "returns the post fields title, published, body, and account" do
        expect(result.dig("data", "post").keys).to eq(%w[title published body account]), result.inspect
      end
      it "returns a single account" do
        expect(result.dig("data", "post", "account")).to be_a(Hash), result.inspect
      end
      it "returns the name and id fields for the account" do
        expect(result.dig(*%w[data post account]).keys).to eq(%w[name id]), result.inspect
      end
      it "returns the correct account id" do
        expect(result.dig(*%w[data post account id])).to eq(post.account.id), result.inspect
      end
    end
  end

end
