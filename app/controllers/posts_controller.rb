class PostsController < ApplicationController
    before_action :initialize_firestore
  
    def index
      @posts = @firestore.col('posts').get.map(&:data)
      render json: @posts
    end
  
    def create
      post_data = params.require(:post).permit(:title, :body).to_h
      puts post_data
      @firestore.col('posts').add(post_data)
      render json: { message: 'Post created successfully' }
    end
  
    def update
      post_data = params.require(:post).permit(:title, :body).to_h
      doc_id = params[:id]
      @firestore.doc("posts/#{doc_id}").set(post_data)
      render json: { message: 'Post updated successfully' }
    end
  
    def destroy
      doc_id = params[:id]
      @firestore.doc("posts/#{doc_id}").delete
      render json: { message: 'Post deleted successfully' }
    end
  
    private
  
    def initialize_firestore
      @firestore = Google::Cloud::Firestore.new project_id: 'echolestia'
    end
  end
  