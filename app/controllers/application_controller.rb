class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:profile]

  def profile
    @user = current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address, :photo])
  end
end
