class AdminController < ApplicationController
    layout false
    before_action :require_admin_login

    def index
        @user = current_user
        @users = User.all
    end

    def user_overview
        user_id = params[:u]
        @user = User.find_by(id: user_id)
        @credits = Credit.where(user: @user)
    end

    def change_user_role
        user_id = params[:u]
        @user = User.find_by(id: user_id)
        if @user.admin == true
            @user.admin = false
            @user.save!
        else
            @user.admin = true
            @user.save!
        end
        redirect_to user_overview_path(:u => @user.id), notice: "Role changed successfully"
    end

    def delete_user
        user_id = params[:u]
        @user = User.find_by(id: user_id)
        @user_credits = Credit.where(user: @user)
        User.destroy(user_id)
        redirect_to admin_path, notice: "User deleted successfully"
    end

    private
    def require_admin_login
        if logged_in?
            if current_user.admin != true
                flash[:error] = "You do not have access to this resource. Log out and try different credentials."
                render :logout
            end
        else
        flash[:error] = "You must be logged in to access the dashboard."
        redirect_to admin_login_path
        end
    end
end