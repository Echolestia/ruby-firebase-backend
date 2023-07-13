class ArticlesController < ApplicationController
    before_action :authenticate
    before_action :set_article, only: [:show, :update, :destroy]
    before_action :set_user_group, only: [:by_user_group]
  
    # GET /articles
    def index
      @articles = Article.all
      render json: @articles
    end
  
    # GET /articles/1
    def show
      render json: @article
    end
    
    # GET /articles/ by user groups CREATE THIS ROUTE - user groups
    def by_user_group
      @articles = Article.where("user_group like ?", @user_group)
      render json: @articles
    end
  
    # POST /articles
    def create
      @article = Article.new(article_params)
      if @article.save
        render json: @article, status: :created, location: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /articles/1
    def update
      if @article.update(article_params)
        render json: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /articles/1
    def destroy
      @article.destroy
    end
  
    private
    def set_article
      @article = Article.find(params[:id])
    end
    
    def article_params
        params.require(:article).permit(:published_date, :created_date, :title, :author, :img_url, :url, user_group: [])
    end

    def set_user_group
      @user_group = "%#{params[:user_group]}%"
    end
      
  end
  