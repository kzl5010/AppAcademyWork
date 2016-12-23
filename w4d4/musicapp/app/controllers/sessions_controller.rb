class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:email], session_params[:password])
    if @user.nil?
      flash.now[:messages] = ["Invalid Login Information"]
      render  :new
    else
      log_in(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil

    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
