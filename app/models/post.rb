class Post < ActiveRecord::Base

  validates_presence_of :title, :body

  scope :published, ->{ where(published: true) }
  scope :drafts, ->{ where.not(published: true) }

  def publish!
    update_attributes!(
      published: true,
      published_at: Time.current
      )
  end

end
