class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def renewal_date
    # Render the renewal date setting page
    @user = current_user # Assuming you have a method to get the current user
  end
  def create
    @user = User.new(user_params)

     if check_if_new_user(user_params[:email])
      if check_if_username_valid(user_params[:username])
        if validate_password(user_params[:password])
          if match_password(user_params[:password], user_params[:password_confirmation])
            specific_params = {
              username: user_params[:username],
              email: user_params[:email],
              password: user_params[:password]
            }
            # @user = User.new(specific_params)

            if @user.save
              cookies.permanent[:auth_token] = @user.auth_token

              redirect_to renewal_date_user_path(@user)
            else
              render :new
            end
          else
            flash[:alert] = "Passwords Mismatch"
            render :new
          end
        else
          flash[:alert] = "Invalid password. Password must be atleast 8 character long with at least one lowercase letter, one uppercase letter, one digit, and one special character"
          render :new
        end
      else
        flash[:alert] = "username already in use"
        render :new
      end
    else
      flash[:alert] = "Email already registered"
      render :new
    end
  end

  def set_renewal_date
    if current_user.update(user_params)
      flash[:notice] = 'Renewal period set successfully.'
      redirect_to dashboard_path
    else
      render :renewal_date
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation ,:renewal_date , :start_date)
  end

  # Method to validate password.
  def validate_password(password)
    password.length >= 8
    if password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/)
      puts "valid password"
      return true
    else
      puts "Password must be atleast 8 character long with at least one lowercase letter, one uppercase letter, one digit, and one special character"
      return false
    end
  end

  def match_password(password, password_confirmation)
    if (password != password_confirmation)
      puts "Passwords don't match"
      return false
    else
      return true
    end
  end

  # username should be unique to every user.
  # Returns false if username is not valid or already in use.
  def check_if_username_valid(username)
    if User.exists?(username: username)
      puts "user with this username already exists"
      return false
    else
      return true
    end
  end

  # method to check if user with email already exists.
  # Returns false if not a new user. Otherwise True.
  def check_if_new_user(email)
    if User.exists?(email: email)
      puts "user with this email already exists"
      return false
    else
      return true
    end
  end
end

