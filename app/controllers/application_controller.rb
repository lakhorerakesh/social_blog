class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :password,
        :password_confirmation, :profile)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:name, :email, :password,
        :password_confirmation, :current_password, :profile, :crop_x, :crop_y, :crop_w, :crop_h)
    end
  end

  def authenticate!
    unless current_user
      render 'authenticate.js.erb'
    end
  end
end

