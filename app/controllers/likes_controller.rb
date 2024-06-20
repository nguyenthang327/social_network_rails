class LikesController < ApplicationController

  def toggle
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user_id: current_user.id)

    if @like
      @like.destroy
      liked = false
    else
      @post.likes.create(user_id: current_user.id)
      liked = true
    end
    respond_to do |format|
      format.json { render json: { liked: liked, likes_count: @post.likes.count, post_id: @post.id } }
    end
  end
end
