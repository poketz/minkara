class Follow < ApplicationRecord
  after_create_commit :create_notifications

  has_one :notification, as: :subject, dependent: :destroy
  belongs_to :follower, class_name: "User", foreign_key: :follower_id
  belongs_to :followee, class_name: "User", foreign_key: :followee_id

  def create_notifications
    Notification.create!(subject: self, user_id: self.followee_id, action: Notification.actions[:follow])
  end
end
