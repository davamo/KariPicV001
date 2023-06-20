class CaptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:new, :create]
  before_action :set_caption, only: [:show, :edit, :update, :destroy]

  def index
    @captions = Caption.all
  end

  def show
    @caption = Caption.find(params[:id])
    @photos = @caption.photos
  end

  def new
    @caption = Caption.new
  end

  def create
    @caption = Caption.new(caption_params)
    @caption.user = current_user

    if @caption.save
      @photo = Photo.new(photo_params)
      @photo.caption = @caption
      if @photo.save
        redirect_to @caption, notice: 'Leyenda y foto creadas exitosamente.'
      else
        # Manejo del error de guardado de la foto
        render :new
      end
    else
      render :new
    end
  end

  def create_photo
    @caption = Caption.find(params[:id])
    @photo = @caption.photos.build(photo_params)

    if @photo.save
      redirect_to @caption, notice: 'La foto ha sido guardada exitosamente.'
    else
      # Manejo del error de guardado de la foto
    end
  end

  def update
    if @caption.update(caption_params)
      redirect_to @caption, notice: 'Caption was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @caption.destroy
    redirect_to captions_url, notice: 'Caption was successfully destroyed.'
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
    params.require(:caption).permit(:text, :user_id, :photo_id)
  end

  def photo_params
    params.require(:caption).require(:photo_attributes).permit(:image)
  end

end
