class UsersController < ApplicationController

  before_action :already_signed_in

  def show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      # session[:session_token] = @user.session_token
      # redirect_to user_url(@user)
      redirect_to cats_url
    else
      flash.now[:messages] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
