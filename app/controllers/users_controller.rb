require 'dropbox_sdk'
require 'base64'
class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def top_upvoted_user
    @users = User.top_upvoted(params[:limit])
  end

  def share_friends_image
    data = params[:image_data]
    image_data = Base64.decode64(data['data:image/png;base64,'.length .. -1])
    file_path = "#{Rails.root}/public/uploads/#{Time.now}.png"
    File.open(file_path, 'wb') do |f|
      f.write image_data
    end
    temp_file = File.open(file_path)
    uploader = FriendProfileUploader.new
    uploader.store!(temp_file)
    uploader.retrieve_from_store!(uploader.filename)
    temp_file.close
    File.delete(temp_file)
    image = uploader.url

    @graph = Koala::Facebook::API.new(current_user.token)
    begin
      @graph.put_picture(image, {:message => "This for test..!!!"})
    rescue => e
      if(e.fb_error_type == "OAuthException")
      end
    end
    flash[:success] = "post shared successfully"
    redirect_to root_path
  end
end