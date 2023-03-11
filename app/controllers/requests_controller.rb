class RequestsController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    @request = Request.new(request_params)
    @request.requester_id = current_user.id
    @request.requested_id = params[:user_id]
    # 曲が存在しているかのチェック
    song = Song.find_by(artist_name:  params[:request][:artist_name], song_name:  params[:request][:song_name])
    if song.present?
      @request.song_id = song.id
    else
      song =  Song.create!(artist_name:  params[:request][:artist_name], song_name:  params[:request][:song_name])
      @request.song_id = song.id
    end
    if @request.save
      redirect_to user_path(params[:user_id]), success: "リクエストを送信しました。"
    else
      render 'users/show'
    end
  end

  def destroy
  end
  
  private

  def request_params
    params.require(:request).permit(:body)
  end
end
