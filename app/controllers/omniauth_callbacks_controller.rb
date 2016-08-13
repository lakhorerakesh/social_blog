class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    omniauth = request.env['omniauth.auth']
    @graph = Koala::Facebook::API.new(omniauth.credentials.token)
    @facebook_friends = @graph.get_connections("me", "friends?fields=id,name,picture")
    session["oauth_obj"] = @facebook_friends
    
    @user = User.from_omniauth(omniauth)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = omniauth
      redirect_to new_user_registration_url
    end
  end

  def fetch_user_friends
    @facebook_friends = session["oauth_obj"]
  end

  def failure
    redirect_to root_path
  end
end