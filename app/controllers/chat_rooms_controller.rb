class ChatRoomsController < ApplicationController
    before_action :set_chat_room, only: [:show, :update, :destroy]
  
    # GET /chat_rooms
    def index
      @chat_rooms = ChatRoom.all
      render json: @chat_rooms
    end
  
    # GET /chat_rooms/1
    def show
      render json: @chat_room
    end
  
    # POST /chat_rooms
    def create
      @chat_room = ChatRoom.new(chat_room_params)
      if @chat_room.save
        render json: @chat_room, status: :created, location: @chat_room
      else
        render json: @chat_room.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /chat_rooms/1
    def update
      if @chat_room.update(chat_room_params)
        render json: @chat_room
      else
        render json: @chat_room.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /chat_rooms/1
    def destroy
      @chat_room.destroy
    end
  
    private
    def set_chat_room
      @chat_room = ChatRoom.find(params[:id])
    end
    
    def chat_room_params
      params.require(:chat_room).permit(:overall_sentiment_analysis_score, :date_created, :is_ai_chat, :is_group_chat)
    end
    
  end
  