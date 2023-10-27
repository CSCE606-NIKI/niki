class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  helper_method :require_login
  private
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  private
  def logged_in?
    !current_user.nil?
  end

  private
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access the dashboard."
      redirect_to login_path
    end
  end


end
