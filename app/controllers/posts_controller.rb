class PostsController < ApplicationController
  def show
    @post = Post.where(user_id: @current_user.id)
    render json: { post: @post }
  end

  def create_post
    @posts = Post.new(post_params.merge(user_id: @current_user.id))
    if @posts.save
      render json: { post: @posts }
    else
      render json: { message: 'No post found' }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
