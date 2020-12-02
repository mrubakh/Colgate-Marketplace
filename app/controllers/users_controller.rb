class UsersController < ApplicationController
  def show
      @user = User.find(params[:userID])
  end
  
  def edit
    @user = User.find(params[:id])
    if(@user != current_user)
      flash[:alert] = "You can only edit your own profile."
      redirect_to root_path and return
    end
  end
    
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
    flash[:success] = "Edit Successful."
    redirect_to root_path
    else
      flash[:notice] = "Did not update successfully"
      render 'edit'
    end
  end
  
  private
  def user_params
      params.require(:user).permit(:name, :payment)
  end
end
