class PostComment < ApplicationRecord
  has_one :notification, as: :subject, dependent: :destroy
  belongs_to :post
  belongs_to :user
end
