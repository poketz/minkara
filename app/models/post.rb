class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :song

  mount_uploader :audio, AudioUploader
  is_impressionable

  def self.search(word)
    # キーワード検索から曲を特定
    songs = Song.where(["artist_name like? OR song_name like?", "%#{word}%", "%#{word}%"])
    # 曲のidに合致する投稿を抽出
    Post.where(song_id: songs.ids)
  end
end
