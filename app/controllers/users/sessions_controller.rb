class Users::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end

  protected
    # ユーザーの状態を判断するメソッド
    def user_state
      ## 入力されたnameからアカウントを1件取得
      @user = User.find_by(name: params[:user][:name])
      ## アカウントを取得できなかった場合、このメソッドを終了する
      return if !@user
      if @user.valid_password?(params[:user][:password]) && !@user.active?
        redirect_to root_path, danger: "利用停止中もしくは退会したユーザーです。"
      end
    end
end
