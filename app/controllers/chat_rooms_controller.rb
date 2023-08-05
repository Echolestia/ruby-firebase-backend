class ChatRoomsController < ApplicationController
  before_action :authenticate
  before_action :set_chat_room, only: [:show, :update, :destroy]

  # GET /chat_rooms
  def index
    if params[:ai] == 'true'
      @chat_rooms = ChatRoom.where(user2_id: -1) # Retrieve only the chat rooms where user2_id is -1 if ai=true
    elsif params[:user]
      user_id = params[:user].to_i
      @chat_rooms = ChatRoom.where("user1_id = :user_id OR user2_id = :user_id", user_id: user_id)

      @chat_rooms = @chat_rooms.map do |room|
        opponent_id = room.user1_id == user_id ? room.user2_id : room.user1_id
        opponent = User.find(opponent_id)
        last_message = room.messages.last
        unread_messages_count = room.messages.where(read: false, receiver_id: user_id).count
        room.as_json.merge({
          opponent_id: opponent_id, 
          opponent_first_name: opponent.first_name, 
          opponent_second_name: opponent.second_name, 
          opponent_user_type: opponent.user_type,
          opponent_picture: opponent.profile,
          last_message: last_message,
          unread_messages_count: unread_messages_count
        })
      end
    else
      @chat_rooms = ChatRoom.all
    end

    render json: @chat_rooms
  end

  # GET /chat_rooms/1
  def show
    if params[:withMessages] == 'true'
      user1 = User.find(@chat_room.user1_id)
      user2 = User.find(@chat_room.user2_id)
      unread_messages_count_user1 = @chat_room.messages.where(read: false, receiver_id: user1.id).count
      unread_messages_count_user2 = @chat_room.messages.where(read: false, receiver_id: user2.id).count

      @chat_room_with_messages = @chat_room.as_json.merge({
        user1_id: user1.id,
        user1_first_name: user1.first_name,
        user1_second_name: user1.second_name,
        user1_picture: user1.profile,
        unread_messages_count_user1: unread_messages_count_user1,
        
        user2_id: user2.id,
        user2_first_name: user2.first_name,
        user2_second_name: user2.second_name,
        user2_picture: user2.profile,
        unread_messages_count_user2: unread_messages_count_user2,
        
        messages: @chat_room.messages.order(created_at: :asc)
      })

      render json: @chat_room_with_messages
    else
      render json: @chat_room
    end
  end




  # POST /chat_rooms
  def create
    if params[:ai] == 'true'
      params[:chat_room][:user2_id] = -1 # Set user2_id to -1 if ai=true
    end
    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      render json: @chat_room, status: :created, location: @chat_room
    else
      render json: @chat_room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chat_rooms/1
  def update
    if params[:ai] == 'true'
      params[:chat_room][:user2_id] = -1 # Set user2_id to -1 if ai=true
    end
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

  # GET /chat_rooms_for_user/:user_id
  def chat_rooms_for_user
    user_id = params[:user_id].to_i
    @chat_rooms = ChatRoom.where("user1_id = :user_id OR user2_id = :user_id", user_id: user_id)

    @chat_rooms = @chat_rooms.map do |room|
      opponent_id = room.user1_id == user_id ? room.user2_id : room.user1_id
      opponent = User.find(opponent_id)
      last_message = room.messages.last
      unread_messages_count = room.messages.where(read: false, receiver_id: user_id).count
      room.as_json.merge({
        opponent_id: opponent_id, 
        opponent_first_name: opponent.first_name, 
        opponent_second_name: opponent.second_name, 
        opponent_user_type: opponent.user_type,
        opponent_picture: opponent.profile,
        last_message: last_message,
        unread_messages_count: unread_messages_count
      })
    end

    render json: @chat_rooms
  end
    
  # GET /chat_rooms_with_messages/:id
  def show_with_messages
    set_chat_room
    user1 = User.find(@chat_room.user1_id)
    user2 = User.find(@chat_room.user2_id)
    unread_messages_count_user1 = @chat_room.messages.where(read: false, receiver_id: user1.id).count
    unread_messages_count_user2 = @chat_room.messages.where(read: false, receiver_id: user2.id).count

    @chat_room_with_messages = @chat_room.as_json.merge({
      user1_id: user1.id,
      user1_first_name: user1.first_name,
      user1_second_name: user1.second_name,
      user1_picture: user1.profile,
      unread_messages_count_user1: unread_messages_count_user1,
      
      user2_id: user2.id,
      user2_first_name: user2.first_name,
      user2_second_name: user2.second_name,
      user2_picture: user2.profile,
      unread_messages_count_user2: unread_messages_count_user2,
      
      messages: @chat_room.messages.order(created_at: :asc)
    })

    render json: @chat_room_with_messages
  end

  private
  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
  
  def chat_room_params
    params.require(:chat_room).permit(:user1_id, :user2_id, :overall_sentiment_analysis_score, :date_created, :is_ai_chat, :is_group_chat)
  end


  
end


