class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  after_action :set_locale_cookie

  layout :resolve_layout

  def admin_access_denied(exception)
    redirect_to root_path, alert: t(:no_rights)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :image
    devise_parameter_sanitizer.for(:account_update) << :name << :image
  end

  def check_badge(name)
    if user_signed_in?
      Badge.check_badge name, current_user
    end
  end

  def sort_by_position(chapters)
    chapters.sort_by { |chapter| chapter.position }
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

  def set_locale
    I18n.locale = cookies[:locale] || params[:locale] || I18n.default_locale
  end

  def set_locale_cookie
    cookies.permanent[:locale] = I18n.locale.to_s
  end

end
