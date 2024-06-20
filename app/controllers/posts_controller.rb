class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user, :comments, :likes).order(id: :desc).paginate(page: params[:page], per_page: 5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
    render json: @post
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_back fallback_location: posts_url, notice: 'Successfully updated.'
    else
      redirect_back fallback_location: posts_url, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_back fallback_location: posts_url, notice: 'Successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
