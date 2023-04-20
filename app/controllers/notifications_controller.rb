class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(20)
  end

  def read
    notification = current_user.notifications.find(params[:id])
    unless notification.read?
      notification.update(read: true)
    end
    redirect_to transition_path(notification)
  end

  def read_all
    current_user.notifications.update_all(read: true)
    redirect_to user_notifications_path(current_user.id)
  end
  # アクションタイプごとにリダイレクト先を指定
  def transition_path(notification)
    case notification.action
    when "request"
      # モーダルにリダイレクトするには？
      user_requests_path(notification.subject.requested_id)
    when "post_comment"
      post_path(notification.subject.post_id)
    when "follow"
      user_path(notification.subject.follower_id)
    else
      root_path
    end
  end
end
