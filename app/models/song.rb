class Song < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :requests, dependent: :destroy

  validates :artist_name, presence: :true
  validates :song_name, presence: :true
end
