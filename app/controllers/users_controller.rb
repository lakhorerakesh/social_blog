class UsersController < ApplicationController
  
  def show
    @user = current_user
  end

  def top_upvoted_user
    @users = User.top_upvoted(params[:limit])
  end
end
