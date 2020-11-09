class UsersController < ApplicationController
    #devise takes care of these
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "New user #{@user.email} created"
            redirect_to root_path and return
        else
            flash[:alert] = "Failed to save new user"
            redirect_to new_user_path and return
        end
    end
    
    def show
        @user = User.find(params[:userID])
    end
end
