class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user && @user.persisted?
        #Only log them in if using Colgate email
        if (/@colgate\.edu$/.match(@user.email)) 
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
          sign_in_and_redirect @user, event: :authentication
        else
          flash[:notice] = "Please use a @colgate.edu email address to log in."
          redirect_to root_path
        end
      end
  end
end