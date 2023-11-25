class AdminController < ApplicationController
    layout false
    def index
        if logged_in?
            @user = current_user
            if (@user.admin != true)
                render :logout
            end

            @users = User.all
        else
            redirect_to admin_login_path
        end
    end

    def user_overview
        user_id = params[:u]
        @user = User.find_by(id: user_id)
        @credits = Credit.where(user: @user)
    end

    def change_user_role
        user_id = params[:u]
        @user = User.find_by(id: user_id)
        if @user != nil
            if @user.admin == true
                @user.admin = false
                @user.save!
            else
                @user.admin = true
                @user.save!
            end
            redirect_to user_overview_path(:u => @user.id)
        else
            flash[:error] = "User doesn't exist"
        end
    end

    def delete_user
        user_id = params[:u]
        @user = User.find_by(id: user_id)
        @user_credits = Credit.where(user: @user)
        User.destroy(user_id)
        redirect_to admin_path, notice: "User deleted successfully"
    end
end