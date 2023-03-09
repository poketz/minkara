class PostComment < ApplicationRecord
  after_create_commit :create_notifications

  has_one :notification, as: :subject, dependent: :destroy
  belongs_to :post
  belongs_to :user

  validates :body, presence: true, length: {maximum: 150}

  def create_notifications

    Notification.create!(subject: self, user_id: self.post.user.id, action: Notification.actions[:post_comment])
  end
end
