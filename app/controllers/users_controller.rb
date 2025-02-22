class UsersController < ApplicationController
    skip_before_action :require_user, only: [:new, :create]

    def index
      @users = User.all
    end
  
    def new
      @user = User.new
    end
    def create
        @user = User.new(user_params)
          if @user.save
            redirect_to users_path, notice: 'User was successfully created.'
          else
            render :new
          end
      end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation,:role)
    end

end
