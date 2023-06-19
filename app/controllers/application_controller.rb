class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    captions_path
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, images_attributes: [:url, :context, :id]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, images_attributes: [:url, :context, :id]])
  end
end
