class Follow < ApplicationRecord
  has_one :notification, as: :subject, dependent: :destroy
  belongs_to :user
end
