class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :song

  mount_uploader :audio, AudioUploader

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

  # 同じ歌手の投稿から自分の投稿、表示中の投稿、いいね済を除外しいいねが多い順に並べる
  def self.post_recommend(user, pos, artist_name)
    songs = Song.where(artist_name: artist_name).pluck(:id)
    like_posts = user.likes.pluck(:post_id)
    Post.where(song_id: songs).where.not(user_id: user.id).where.not(id: pos.id).where.not(id: like_posts).sort { |a, b| b.likes.count <=> a.likes.count }
  end
end
