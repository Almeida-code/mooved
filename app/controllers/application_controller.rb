class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Custom redirection after sign-in based on role
  def after_sign_in_path_for(resource)
    puts "Role of logged-in user: #{resource.role}"
    if resource.role == 'company'
      trucks_path  # Redirects customers (truck managers) to their trucks page
    else
      bookings_path  # Redirects clients to the bookings page
    end
  end

  # Custom redirection after sign-up based on role
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)  # Reuses the sign-in redirection logic
  end

  # Permit additional Devise parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :role])
  end
end
