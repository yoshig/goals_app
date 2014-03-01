class CommentsController < ApplicationController
  def create
    class_type = params[:comment][:target_class] == "User" ? User : Goal
    target = class_type.find(params[:comment][:target_id])
    @comment = target.comments.new(comment_params)
    @comment.user = current_user
    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end

    redirect_to target.class == User ? user_url(target) : user_url(target.user)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
