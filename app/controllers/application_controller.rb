class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  helper_method :require_login
  before_action :check_and_renew_credits

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

  def check_and_renew_credits
    return unless logged_in? # Check if the user is logged in
  
    @user = current_user
    user_renewal_date = @user.renewal_date
    current_date = Date.today
    if(user_renewal_date!=nil)
      if current_date >= user_renewal_date
        unless request.path == renewal_date_user_path(@user) || request.path == set_renewal_date_user_path(@user)
          # Only redirect if the current page is not the renewal date setting page
          redirect_to renewal_date_user_path(@user)
        end
      end
    end
  end

  public :def check_renewal_date_to_email
    return unless logged_in? # Check if the user is logged in
    
    puts "*********HEREEeeeeeeeeeee**********"
    @user = current_user
    user_renewal_date = @user.renewal_date
    current_date = Date.today

    # Check if user_renewal_date is exactly 3 months away from current_date
    if user_renewal_date == (current_date + 1.months)
      CreditMailer.send_pending_credits_email # Call your method to send the email here
    end
  end

  
end