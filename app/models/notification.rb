class Notification < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user
  
  enum action: {
    request: 0,
    follow: 1,
    post_comment: 2
  }
end
