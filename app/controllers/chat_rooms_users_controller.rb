class ChatRoomUsersController < ApplicationController
    before_action :set_chat_room_user, only: [:show, :update, :destroy]
  
    # GET /chat_room_users
    def index
      @chat_room_users = ChatRoomUser.all
      render json: @chat_room_users
    end
  
    # GET /chat_room_users/1
    def show
      render json: @chat_room_user
    end
  
    # POST /chat_room_users
    def create
      @chat_room_user = ChatRoomUser.new(chat_room_user_params)
      if @chat_room_user.save
        render json: @chat_room_user, status: :created, location: @chat_room_user
      else
        render json: @chat_room_user.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /chat_room_users/1
    def update
      if @chat_room_user.update(chat_room_user_params)
        render json: @chat_room_user
      else
        render json: @chat_room_user.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /chat_room_users/1
    def destroy
      @chat_room_user.destroy
    end
  
    private
      def set_chat_room_user
        @chat_room_user = ChatRoomUser.find(params[:id])
      end
  
      def chat_room_user_params
        params.require(:chat_room_user).permit(:chat_room_id, :user_id)
      end
  end
  