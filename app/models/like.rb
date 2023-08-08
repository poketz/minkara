class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  scope :liked_this_week, -> { where(created_at: Time.current.all_week) } 
end
