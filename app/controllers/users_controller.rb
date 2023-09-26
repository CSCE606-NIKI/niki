class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
     if check_if_new_user(user_params[:email])
      if check_if_username_valid(user_params[:username])
        if validate_password(user_params[:password], user_params[:password_confirmation])
          specific_params = {
            username: user_params[:username],
            email: user_params[:email],
            password_digest: user_params[:password]
          }
          @user = User.new(specific_params)

          if @user.save
            redirect_to login_path(@user)
          else
            render :new
          end
        else
          flash[:alert] = "Invalid password. Password must include at least one lowercase letter, one uppercase letter, one digit, and one special character"
          redirect_to new_user_path(@user)
        end
      else
        flash[:alert] = "username already in use"
        redirect_to new_user_path(@user)
      end
    else
      flash[:alert] = "Email already registered"
      redirect_to new_user_path(@user)
    end
  end



  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  # Method to validate password.
  def validate_password(password, password_confirmation)
    password.length >= 6
    password == password_confirmation
    if password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/)
      puts "valid"
      return true
    else
      puts "password must include at least one lowercase letter, one uppercase letter, one digit, and one special character"
      return false
    end
  end

  # username should be unique to every user.
  # Returns false if username is not valid or already in use.
  def check_if_username_valid(username)
    if User.exists?(username: username)
      return false
    else
      return true
    end
  end

  # method to check if user with email already exists.
  # Returns false if not a new user. Otherwise True.
  def check_if_new_user(email)
    if User.exists?(email: email)
      return false
    else
      return true
    end
  end
end

