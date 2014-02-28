class SessionsController < ApplicationController
  before_action :verify_logged_in, only: [:destroy]
  def new
    @user = User.new
    render "new"
  end

  def create
    @user = User.find_by_credentials(auth_params)
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(auth_params)
      flash.now[:errors] = "No user found for this Username/Password combo"
      render "new"
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private

  def auth_params
    params.require(:user).permit(:username, :password)
  end
end
