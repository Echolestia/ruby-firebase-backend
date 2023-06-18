class PostsController < ApplicationController

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: { message: 'Post created successfully' }
    else
      render json: { message: 'Post creation failed' }
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: { message: 'Post updated successfully' }
    else
      render json: { message: 'Post update failed' }
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      render json: { message: 'Post deleted successfully' }
    else
      render json: { message: 'Post deletion failed' }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
