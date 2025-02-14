class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      # raise session["devise.facebook_data"].inspect
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:success] = "#{t('devise.registrations.facebook')}"
      redirect_to send("new_#{session["user_role"].singularize}_url")
    end
  end
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_google_oauth2(request.env["omniauth.auth"])

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        flash[:success] = "#{t('devise.registrations.google_plus')}"
        redirect_to send("new_#{session["user_role"].singularize}_url")
      end
  end
end