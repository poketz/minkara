class Request < ApplicationRecord
  after_create_commit :create_notifications
  
  has_one :notification, as: :subject, dependent: :destroy
  belongs_to :requester, class_name: "User", foreign_key: :requester_id
  belongs_to :requested, class_name: "User", foreign_key: :requested_id
  belongs_to :song
  
  def create_notifications
    Notification.create!(subject: self, user_id: self.requested_id, action: Notification.actions[:request])
  end
end
