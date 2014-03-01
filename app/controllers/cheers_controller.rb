class CheersController < ApplicationController
  before_action :verify_logged_in
  MAX_CHEERS = 1

  def create
    if current_user.cheers.count < MAX_CHEERS
      cheer = current_user.cheers.new(:goal_id => params[:cheer][:goal_id])
      cheer.save
    else
      flash[:errors] = "Cheers limit reached"
    end
    redirect_to user_url(Goal.find(params[:cheer][:goal_id]).user)
  end
end
