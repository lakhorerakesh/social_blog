class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    omniauth = request.env['omniauth.auth']
    @graph = Koala::Facebook::API.new(omniauth.credentials.token)

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
    @graph = Koala::Facebook::API.new(current_user.token)
    @facebook_friends = @graph.get_connections("me", "friends?fields=id,name,picture")
  end

  def share_user_friends_profile
    test = params[:total_changes]
    @result = []
    test.each do |f|
      @result = @result.push(eval(f))
    end
    respond_to do|format|
      format.js 
    end
  end

  def failure
    redirect_to root_path
  end
end