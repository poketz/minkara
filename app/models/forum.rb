class Forum < ApplicationRecord
  has_many :forum_comments, dependent: :destroy
  has_many :forum_favorites, dependent: :destroy
end
