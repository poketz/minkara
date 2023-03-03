class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :song

  mount_uploader :audio, AudioUploader
  is_impressionable

  def self.search(search, word)
    # キーワード検索からユーザーを特定
    if search == "perfect_match"
      @songs = Song.where("artist_name like? OR song_name like?","#{word}","#{word}")
    elsif search == "forward_match"
      @songs = Song.where("artist_name like? OR song_name like?", "#{word}%","#{word}%")
    elsif search == "backward_match"
      @songs = Song.where("artist_name like? OR song_name like?","%#{word}","%#{word}")
    elsif search == "partial_match"
      @songs = Song.where("artist_name like? OR song_name like?","%#{word}%","%#{word}%")
    else
      @songs = Song.all
    end
    
    # 曲のidに合致する投稿を抽出
    Post.where(song_id: @songs.ids)
  end
end
