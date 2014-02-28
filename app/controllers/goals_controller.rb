class GoalsController < ApplicationController
  before_action :verify_logged_in

  def create
    @goal = current_user.goals.new(goal_params)
    unless @goal.save
      flash[:errors] = @goal.errors.full_messages
    end

    redirect_to user_url(current_user)
  end

  def destroy
    @goal = current_userl.goals.find(params[:id])
    @goal.destroy if @goal
    redirect_to user_url(current_user)
  end

  def toggle_completion
    goal = current_user.goals.find(params[:id])

    if goal
      goal.toggle_completion!
      redirect_to user_url(goal.user)
    else
      flash[:errors] = ["How did you do that?! Stop it!"]
      redirect_to user_url(current_user)
    end
  end

  def toggle_privacy
    goal = Goal.find(params[:id])
    if goal
      goal.toggle_privacy!
      redirect_to user_url(goal.user)
    else
      flash[:errors] = ["How did you do that?! Stop it!"]
      redirect_to user_url(current_user)
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :privacy)
  end
end
