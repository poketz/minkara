class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:search]
  before_action :guest_check, only: [:new]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    Post.post_create(params[:post][:artist_name], params[:post][:song_name], @post)
    if @post.save
      redirect_to user_path(current_user.id), success: "楽曲を投稿しました。"
    else
      # PostモデルのエラーからSongモデルのアソシエーションのエラーを削除
      @post.errors.delete(:song)
      render "new"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to user_path(current_user.id), success: "投稿曲の設定を変更しました。"
    else
      render "users/show"
    end
  end

  def destroy
    pos = Post.find(params[:id])
    pos.destroy
    redirect_to user_path(current_user.id), success: "投稿を削除しました。"
  end

  def show
    @post = Post.find(params[:id])
    @posts = Post.post_recommend(current_user, @post, @post.song.artist_name)
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all
  end

  def search
    @posts = Post.search(params[:search], params[:word])
    @post_search_result = @posts.page(params[:page]).per(10)
    if @posts.count != 0
      flash.now[:primary] = "#{@posts.count}件の投稿が見つかりました。"
    else
      flash.now[:danger] = "投稿が見つかりませんでした。"
    end
  end

  # def autocomplete_song
  #   # params[:company]の値でUser.companyを前方一致検索、company列だけ取り出し、nilと空文字を取り除いた配列
  #   songs = Song.by_song_like(autocomplete_params[:song_name]).pluck(:song_name).reject(&:blank?)
  #   render json: songs
  #   # レスポンスの例: ["てすと１会社","てすと２会社","てすと３会社"]
  # end

  private
    def post_params
      params.require(:post).permit(:audio, :open_range, :poster_comment)
    end

    # def autocomplete_params
    #     params.permit(:song_name)
    # end

    def is_matching_login_user
      pos = Post.find(params[:id])
      unless pos.user_id == current_user.id
        redirect_to user_path(current_user.id)
      end
    end
end
