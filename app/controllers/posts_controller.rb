class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 曲が存在しているかのチェック
    song = Song.find_by(artist_name:  params[:post][:artist_name], song_name:  params[:post][:song_name])
    if song.present?
      @post.song_id = song.id
    else
      song =  Song.create!(artist_name:  params[:post][:artist_name], song_name:  params[:post][:song_name])
      @post.song_id = song.id
    end
    if @post.save
      redirect_to user_path(current_user.id)
    else
      render 'show'
    end
  end

  def update
  end

  def destroy
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all
  end

  private

  def post_params
    params.require(:post).permit(:audio, :poster_comment)
  end
end
