class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name name bio])
  end

  protected

  def after_sign_up_path_for(_resource)
    new_user_session_path
  end
end
