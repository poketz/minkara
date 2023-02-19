class Notification < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :
end
