class Song < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :requests, dependent: :destroy
end
