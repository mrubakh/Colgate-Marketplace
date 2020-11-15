class UsersController < ApplicationController
  def show
      @user = User.find(params[:userID])
  end
  
  def edit
    @user = User.find(params[:id])
  end
    
  def update
    @user = User.find(params[:id])
    params.permit!
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      flash[:notice] = "Did not update successfully"
      render 'edit'
    end
  end
end
