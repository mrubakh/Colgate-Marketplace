class UsersController < ApplicationController
    # def new
    #     @user = User.new
    # end
    
    # def create
    #     @user = User.new(user_params)
    #     if @user.save
    #         flash[:notice] = "New user #{@user.email} created"
    #         redirect_to root_path and return
    #     else
    #         flash[:alert] = "Failed to save new user"
    #         redirect_to new_user_path and return
    #     end
    # end
    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user && @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user, event: :authentication
      else
        email = request.env['omniauth.auth'].info.email
        flash[:warning] = "No user #{email} configured; contact the administrator"
        redirect_to new_user_session_path and return
      end
    end
    
    def show
        @user = User.find(params[:userID])
    end
end
