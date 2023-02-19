class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :forum_comments, dependent: :destroy
  has_many :forum_favorites, dependent: :destroy
  
  enum gender: { male: 0, female: 1, other: 2 }
end
