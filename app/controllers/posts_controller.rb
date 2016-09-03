class PostsController < ApplicationController

  before_action :authenticate!, only: [:vote]
  before_action :find_post, only: [:show, :edit, :update, :destroy, :display_post_of_current_user, :vote]
  
  def index
    @posts = Post.all
    if params[:search]
      @posts = @posts.search(params[:search]).order("created_at ASC")
    end
  end

  def show
  end

  def share_on_facebook
    @post = Post.find(params[:id])
  end

  def share
    @post = Post.find(params[:id])
    @graph = Koala::Facebook::API.new(current_user.token)
    @graph.put_wall_post("Sharing Post through rails app!", {
      "name" => "#{@post.title}",
      "link" => "http://localhost:3000/posts/#{@post.id}/share_on_facebook",
      "caption" => "share post through koala gem",
      "picture" => "http://localhost:3000/public/#{@post.image}/thumb.jpg",
      "description" => "#{@post.description}"
    })
    flash[:success] = "post shared successfully"
    redirect_to root_path
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    if create_post?
      # crop profile image if present
      if image_exists?
        render 'trim'
      else
        redirect_to display_post_path(@post)
        flash[:success] = "Post created successfully"
      end
    else
      render 'new'
    end
  end

  def update
    if update_post?
      # crop profile image if present
      if image_exists?
        render 'trim'
      else
        flash[:success] = "Post updated successfully"
        redirect_to display_post_path(@post)
      end
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to show_my_posts_path 
    flash[:success] = "Post deleted successfully"
  end

  def show_all_post_of_current_user
    @current_user_posts = current_user.posts.all
  end

  def display_post_of_current_user
  end

  def vote
    @vote = @post.votes.new :user_id => current_user.id, :vote => params[:vote]
    if @vote.save
      respond_to do |format|
        format.js
      end
    end
  end 

  private

  def create_post?
    @post = current_user.posts.build(post_params)
    @post.save
  end

  def update_post?
    @post.update(edit_post_params)
  end

  def image_exists?
    params[:post][:image].present?
  end

  def find_post
    if current_user
      @post = Post.find(params[:id]) || current_user.posts.find(params[:id]) 
    else
      @post = Post.find(params[:id])
    end
  end

  def post_params
    params.require(:post).permit(:title, :description, :date, :category, :image, :trim_x, :trim_y, :trim_w, :trim_h)
  end

  def edit_post_params
    params.require(:post).permit(:title, :description, :image, :trim_x, :trim_y, :trim_w, :trim_h)
  end
end
