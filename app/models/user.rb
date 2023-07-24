class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_requests, class_name: "Request", foreign_key: :requester_id, dependent: :destroy
  has_many :passive_requests, class_name: "Request", foreign_key: :requested_id, dependent: :destroy
  has_many :active_follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: :followee_id, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # フォロー一覧を表示するための記述
  has_many :followings, through: :active_follows, source: :followee
  # フォロワー一覧を表示するための記述
  has_many :followers, through: :passive_follows, source: :follower

  validates :name, presence: :true
  validates :prefecture, exclusion: { in: ["please_select"] }

  enum user_status: { active: 0, out_of_servise: 1, withdrawal: 2 }
  enum gender: { male: 0, female: 1, other: 2 }
  enum prefecture: {
    please_select: 0,
    hokkaido: 1, aomori: 2, iwate: 3, miyagi: 4, akita: 5, yamagata: 6, fukushima: 7,
    ibaraki: 8, tochigi: 9, gunma: 10, saitama: 11, chiba: 12, tokyo: 13, kanagawa: 14,
    niigata: 15, toyama: 16, ishikawa: 17, fukui: 18, yamanashi: 19, nagano: 20,
    gifu: 21, shizuoka: 22, aichi: 23, mie: 24,
    shiga: 25, kyoto: 26, osaka: 27, hyogo: 28, nara: 29, wakayama: 30,
    tottori: 31, shimane: 32, okayama: 33, hiroshima: 34, yamaguchi: 35,
    tokushima: 36, kagawa: 37, ehime: 38, kochi: 39,
    fukuoka: 40, saga: 41, nagasaki: 42, kumamoto: 43, oita: 44, miyazaki: 45, kagoshima: 46,
    okinawa: 47
  }

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize: "#{width}x#{height}^", gravity: "center", crop: "#{width}x#{height}+0+0").processed
  end

  # ユーザー検索
  def self.search(search, word)
    # キーワード検索からユーザーを特定
    if search == "perfect_match"
      User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      User.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      User.where("name LIKE?", "%#{word}%")
    else
      User.all
    end
  end

  # フォローしたときの処理
  def follow(user_id)
    Follow.create(follower_id: self.id, followee_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    Follow.find_by(followee_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  # 相互フォロー判定
  def self.mutual_follows?(pos_user, current_user)
    current_user.following?(pos_user) && pos_user.following?(current_user)
  end
  
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.prefecture = "tokyo"
      user.gender = "male"
      user.birthday = "2000-01-01"
    end
  end
end
