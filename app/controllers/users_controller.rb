class UsersController < ApplicationController
  
  def show
    @user = current_user
  end

  def top_upvoted_user
    @users = User.top_upvoted(params[:limit])
  end

  def share_user_friends_profile
    test = params[:total_changes]
    test.each do |f|
      @result = eval(f)
      puts "----------#{@result}"

      @val = @result.values_at(:id, :name, :image)
      puts "-----------#{@val[1]}"
      puts "-----------#{@val[2]}"
      #@graph = Koala::Facebook::API.new(current_user.token)
      #@graph.put_picture("#{@image}", {:caption => "#{@object}"})
    end
    #result = eval(test)
=begin
    @graph = Koala::Facebook::API.new(current_user.token)
    @friends = @graph.get_connections("me", "friends?fields=id,name,picture")
    @friends.each do |f|
      @object = f["name"]
      @image = f["picture"]["data"]["url"]
      puts "=======#{@object}"
    end
=end


    #@graph.put_picture("#{@image}", {:caption => "#{@object}"})

    #flash[:success] = "post shared successfully"
    respond_to do |format|
      format.js
    end
  end
end