class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :contact_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :contact_number])
  end
end
