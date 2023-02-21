class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    
  end

  def show_info
  end

  def edit
  end

  def update
  end

  def confirm
  end

  def withdraw
  end
end
