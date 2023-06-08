class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :song

  mount_uploader :audio, AudioUploader
  validates :audio, presence: { message: "を選択してください" }

  def self.search(search, word)
    # キーワード分割
    keywords = word&.split(/[[:blank:]]+/)&.select(&:present?)
    @songs = Song.all
    # キーワード検索から楽曲を特定
    if search == "perfect_match"
      @songs = @songs.where("artist_name like? OR song_name like?", "#{word}", "#{word}")
    elsif search == "forward_match"
      @songs = @songs.where("artist_name like? OR song_name like?", "#{word}%", "#{word}%")
    elsif search == "backward_match"
      @songs = @songs.where("artist_name like? OR song_name like?", "%#{word}", "%#{word}")
    elsif search == "partial_match"
      keywords.each do |keyword|
        @songs = @songs.where("artist_name like? OR song_name like?", "%#{keyword}%", "%#{keyword}%")
      end
    end
    # 曲のidに合致する投稿を抽出
    Post.where(song_id: @songs.ids).order("created_at DESC")
  end

  # # サジェスト用の前方一致検索
  # scope :by_song_like, -> (song) { where('song LIKE :value', { value: "#{song}%"}) }

  # 同じ歌手の投稿から自分の投稿、表示中の投稿、いいね済を除外しいいねが多い順に並べる
  def self.post_recommend(user, pos, artist_name)
    songs = Song.where(artist_name: artist_name).pluck(:id)
    like_posts = user.likes.pluck(:post_id)
    @posts = Post.where(song_id: songs).where.not(user_id: user.id).where.not(id: pos.id).where.not(id: like_posts).limit(5).sort { |a, b| b.likes.count <=> a.likes.count }
  end

  def self.post_create(artist_name, song_name, pos)
    # 曲が存在しているかのチェック
    # エラーメッセージにsongの情報を渡すために$を
    $song = Song.find_by(artist_name: artist_name, song_name: song_name)
    if $song.present?
      pos.song_id = $song.id
    else
      $song = Song.create(artist_name: artist_name, song_name: song_name)
      pos.song_id = $song.id
    end
  end
end
