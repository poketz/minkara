class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def guest_check
    if current_user == User.find_by(email: 'guest@example.com')
      redirect_to user_path(current_user.id), alert: "このページを閲覧するには会員登録が必要です。"
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:name, :email, :gender, :birthday, :prefecture])
  end
end
