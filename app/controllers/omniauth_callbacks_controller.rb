class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    omniauth = request.env['omniauth.auth']
    @graph = Koala::Facebook::API.new(omniauth.credentials.token)

    @facebook_friends = @graph.get_connections("me", "friends?fields=id,name,picture")
    puts "===================#{@facebook_friends}"
    session["oauth_obj"] = @facebook_friends

    @facebook_post = @graph.get_connections('me', 'feed')

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

  def share_user_friends_profile

    test = params[:total_changes]
    @result = []
    test.each do |f|
      @result = @result.push(eval(f))
    end

    @name = []
    @img = []
    @result.each do |f|
        @name = @name.push(f[:name])
        @img = @img.push(f[:image])
    end
            
    
    @graph = Koala::Facebook::API.new(current_user.token)
    #@graph.put_picture("#{@img[1]}", {:caption => "#{@name[1]}"})

    respond_to do|format|
      format.js 
    end
    #@graph.put_picture("#{@img}", {:caption => "#{@object}"})

    #flash[:success] = "post shared successfully"

  end

  def failure
    redirect_to root_path
  end
end