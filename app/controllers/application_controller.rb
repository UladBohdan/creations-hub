class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :resolve_layout

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :image
    devise_parameter_sanitizer.for(:account_update) << :name << :image
  end

  private

  def resolve_layout
    case action_name
      when "read"
        "read_layout"
      else
        "application"
    end
  end

end
