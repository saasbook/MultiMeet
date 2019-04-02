class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
            flash[:success] = "Welcome to MultiMeet #{@user.username}!"
            redirect_to projects_path
        else
            flash[:message] = @user.errors.full_messages
            redirect_to signup_path
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
    end
end