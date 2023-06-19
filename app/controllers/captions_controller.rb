class CaptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:new, :create]
  before_action :set_caption, only: [:show, :edit, :update, :destroy]

  def index
    @captions = Caption.all
  end

  def show
    @caption = Caption.find(params[:id])
  end

  def new
    @caption = Caption.new
  end

  def create
    @caption = Caption.new(caption_params)
    @caption.user = current_user
    if @caption.save
      redirect_to @caption, notice: 'Caption creado exitosamente.'
    else
      render :new
    end
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
    params.require(:caption).permit(:text, :user_id, photos_attributes: [:image])
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: 'You must be logged in to perform this action.'
    end
  end
end
