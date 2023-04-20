class PostComment < ApplicationRecord
  after_create_commit :create_notifications

  has_one :notification, as: :subject, dependent: :destroy
  belongs_to :post
  belongs_to :user

  validates :body, presence: true, length: { maximum: 150 }

  def create_notifications
    # セルフコメントは通知を新たに作成しない
    unless self.post.user_id == self.user_id
      Notification.create!(subject: self, user_id: self.post.user_id, action: Notification.actions[:post_comment])
    end
  end
end
