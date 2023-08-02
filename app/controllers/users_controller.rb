class UsersController < ApplicationController
    # before_action :authenticate, except: [:create]
    before_action :set_user, only: [:show, :update, :destroy]
  
    # GET /users
    def index
      @users = User.all
      render json: @users
    end
  
    # GET /users/1
    def show
      render json: @user
    end
  
    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        # Set token to expire in 24 hours
        token_payload = {
          user_id: @user.id,
          exp: (Time.now + 24.hours).to_i
        }
        token = JWT.encode(token_payload, Rails.application.secret_key_base, 'HS256')
        render json: { 
          status: 'Logged in', 
          token: token,
          user_id: @user.id
        }.merge(@user.as_json(except: [:created_at, :updated_at, :id])), status: :created, location: @user  # Merge user fields    
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

  
    # PATCH/PUT /users/1
    def update
      if user_params.nil? || user_params.empty?
        render json: { error: 'invalid parameters' }, status: :unprocessable_entity
      elsif @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /users/1
    def destroy
      @user.destroy
    end
  
    private
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:email, :password, :user_type, :profile, :first_name, :second_name, :age, :occupation, :username, :phone_number, :gender, :pregnant, :marital_status, :pregnancy_week, :is_anonymous_login, :survey_result) if params[:user].present?
    end
    
  end
  