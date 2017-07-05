class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :account
      t.string :title, null: false
      t.text :body, null: false
      t.datetime :published_at
      t.boolean :published, null: false, default: false

      t.timestamps null: false
    end
  end
end
