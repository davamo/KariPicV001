class CaptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:new, :create]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @captions = Caption.all
  end

  def show
    @comment = Comment.find(params[:id])
    @comments = @comment.article.comments
  end

  def new
    @caption = Caption.new
  end

  def create
    @caption = Comment.new(caption_params)
    @caption.user = current_user

    if @caption.save
      redirect_to @caption, notice: 'caption was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @caption.update(caption_params)
      redirect_to @caption, notice: 'caption was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @caption.destroy
    redirect_to captions_url, notice: 'caption was successfully destroyed.'
  end

  private


  def check_admin
    unless current_user.admin?
      flash[:alert] = "Solo los administradores pueden crear nuevos artículos."
      redirect_to root_path
    end
  end

  def set_caption
    @caption = Caption.find(params[:id])
  end

  def caption_params
    params.require(:caption).permit(:title, :content)
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: 'You must be logged in to perform this action.'
    end
  end
end
