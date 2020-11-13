class OmniauthCallbacksController < Devise::OmniauthCallbacksController
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
end


# def google_oauth2
#       # You need to implement the method below in your model (e.g. app/models/user.rb)
#       @user = User.from_omniauth(request.env['omniauth.auth'])

#       if @user.persisted?
#         flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
#         sign_in_and_redirect @user, event: :authentication
#       else
#         session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
#         redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
#       end
#   end
# end