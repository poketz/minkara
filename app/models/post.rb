class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :song
  
  mount_uploader :audio, AudioUploader
  is_impressionable
end
