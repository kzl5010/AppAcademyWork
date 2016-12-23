class PostsController < ApplicationController
  before_action :require_login, except: [:show]
  before_action :require_user_owns_post, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:messages] = @post.errors.full_messages
      render :new
    end
  end


  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:messages] = @post.errors.full_messages
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :user_id, sub_ids: [])
  end

  def require_user_owns_post
    return if Post.find(params[:id]).author == current_user
    redirect_to new_post_url
  end
end
