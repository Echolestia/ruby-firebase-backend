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

    
    # GET /chat_rooms_for_user/:user_id
    def chat_rooms_for_user
      user_id = params[:user_id].to_i
      @chat_rooms = ChatRoom.where("user1_id = :user_id OR user2_id = :user_id", user_id: user_id)

      @chat_rooms = @chat_rooms.map do |room|
        opponent_id = room.user1_id == user_id ? room.user2_id : room.user1_id
        opponent = User.find(opponent_id)
        room.as_json.merge({
          opponent_id: opponent_id, 
          opponent_first_name: opponent.first_name, 
          opponent_second_name: opponent.second_name, 
          opponent_picture: opponent.profile
        })
      end

      render json: @chat_rooms
    end

    # GET /chat_rooms_with_messages/:id
    def show_with_messages
      set_chat_room
      opponent_id = @chat_room.user1_id == params[:user_id].to_i ? @chat_room.user2_id : @chat_room.user1_id
      opponent = User.find(opponent_id)
      @chat_room_with_messages = @chat_room.as_json.merge({
        opponent_id: opponent_id, 
        opponent_first_name: opponent.first_name, 
        opponent_second_name: opponent.second_name, 
        opponent_picture: opponent.profile,
        messages: @chat_room.messages
      })
      
      render json: @chat_room_with_messages
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
  