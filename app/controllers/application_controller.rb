class ApplicationController < ActionController::Base
  def current_user
    @current_user = User.first
  end
  # protect_from_forgery with: :exception

  # before_action :configure_permitted_parameters, if: :devise_controller?

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys) { |u| u.permit(:firstname, :lastname, :email, :password) }
  # end
end
