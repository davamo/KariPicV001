class CommentsController < ApplicationController
  before_action :set_caption
  before_action :require_login

  def show
  end

  def create
    @caption = Caption.find(params[:article_id])
    @comment = @caption.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @article, notice: 'Comment was successfully created.'
    else
      render 'captions/show'
    end
  end

  def destroy
    @caption = @caption.comments.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      redirect_to @caption, notice: 'Comment was successfully destroyed.'
    else
      redirect_to @caption, alert: 'You are not authorized to delete this comment.'
    end
  end

  private

  def set_caption
    @caption = Caption.find(params[:caption_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: 'You must be logged in to perform this action.'
    end
  end
end
