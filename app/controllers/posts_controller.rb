class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:search]
  before_action :guest_check, except: [:search, :show]

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
      @song =  Song.create(artist_name:  params[:post][:artist_name], song_name:  params[:post][:song_name])
      @post.song_id = @song.id
    end
    if @post.save
      redirect_to user_path(current_user.id)
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to user_path(current_user.id), success: "投稿者コメントを変更しました。"
    else
      render 'users/show'
    end
  end

  def destroy
    pos = Post.find(params[:id])
    pos.destroy
    redirect_to user_path(current_user.id), success: "投稿を削除しました。"
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all
    # impressionist(@post, nil, :unique => [:])
  end

  def search

      @posts = Post.search(params[:search], params[:word]).page(params[:page]).per(10)
      if @posts.count != 0
        flash.now[:primary] = "#{@posts.count}件の投稿が見つかりました。"
      else
        flash.now[:danger] = "投稿が見つかりませんでした。"
      end


  end

  private

  def post_params
    params.require(:post).permit(:audio, :poster_comment)
  end
end
