class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:show, :create]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :force_redirect_unless_my_post, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end
  
  def show
    @comments = @post.comments
    @comment = Comment.new
  end
  
  def new
    return redirect_to new_profile_path, alert: "please registration your profile" if current_user.profile.blank?
    @post = Post.new
  end
  
  def edit
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    
    if @post.save
      redirect_to root_path, notice: "Posting Success"
    else
      render :new, notice: "Posting Failed"
    end
    
  end
  
  def update
    if @post.update(post_params)
      redirect_to root_path, notice: "Updated to your post"
    else
      render :edit
    end
  end
  
  def destroy
    if @post.destroy(post_params)
      redirect_to root_path, notice: "Deleted in the post"
    else
      redirect_to root_path, alert: "Could not be deleted"
    end
  end
  
  private 
  
  def post_params
    params.require(:post).permit(
      :content_title, :content, images: []
    )
  end
  
  def find_post
    @post = Post.find(params[:id])
  end

  def force_redirect_unless_my_post
    return redirect_to root_path, alert: "Not your post" if @post.user != current_user
  end

end
