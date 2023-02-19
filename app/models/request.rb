class Request < ApplicationRecord
  has_one :notification, as: :subject, dependent: :destroy
  belongs_to :user
  belongs_to :song
end
