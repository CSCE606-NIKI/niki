class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to dashboard_path # Redirect logged-in users to their profile
    else
      @user = User.new
    end
  end

  def create
    identifier = params[:identifier]

    @user = if identifier.include?('@')  # Check if it looks like an email
      User.find_by('lower(email) = ?', identifier.downcase)
    else
      User.find_by('lower(username) = ?', identifier.downcase)
    end
    if @user && @user.authenticate(params[:password])
        if params[:remember_me]
          cookies.permanent[:auth_token] = @user.auth_token
        else
          cookies[:auth_token] = @user.auth_token
        end
        redirect_to dashboard_path(@user)
    else
        flash[:danger] ='Invalid credentials'
        render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to '/login', notice: 'Logged out successfully'
  end

  def omniauth
    # Create a user object from the response
    # from_omniauth takes care of creating a new user if it doesn't exist yet
    result = User.from_omniauth(request.env['omniauth.auth'])
    if result == nil
      # If the returned result is nil, it means that the email is already in the database but with a different provider/uid
      # This is to prevent account hijacking
      flash[:danger] = "This email is already being used with a different sign-in method. Please use a different sign-in method."
      redirect_to login_path(@user)
    else 
      @user = result
      if @user.valid?
        cookies.permanent[:auth_token] = @user.auth_token
        if @user.renewal_date.nil? && @user.start_date.nil?
            # Check if renewal date or start date is not set
          redirect_to renewal_date_user_path(@user)
        else 
          # Redirect to the dashboard
          redirect_to dashboard_path(@user)
        end
      else
        # If Google returns an invalid hash, take the user to the login page
        redirect_to '/login', notice: 'Authentication failed. Please try again or try a different sign-in method.'
      end
    end
  end
  
  def admin_create
    identifier = params[:username]
    @user = User.find_by('lower(username) = ?', identifier.downcase)
    if @user && @user.authenticate(params[:password])
        cookies[:auth_token] = @user.auth_token
        redirect_to admin_path(@user)
    else
        flash[:danger] ='Invalid credentials'
        render :template => "admin/admin_login", :layout => false
    end
  end

  def admin_new
      render :template => "admin/admin_login", :layout => false
  end

  def admin_destroy
    cookies.delete(:auth_token)
    redirect_to admin_login_path, notice: 'Logged out successfully', :layout => false
  end

end
