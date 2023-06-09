class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(_resource)
    user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[firstname lastname email password])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[firstname lastname email password current_password])
  end
end
