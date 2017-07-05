class Post < ActiveRecord::Base

  belongs_to :account

  validates_presence_of :title, :body
  validates_presence_of :account

  scope :published, ->{ where(published: true) }
  scope :drafts, ->{ where.not(published: true) }

  def publish!
    update_attributes!(
      published: true,
      published_at: Time.current
      )
  end

end
