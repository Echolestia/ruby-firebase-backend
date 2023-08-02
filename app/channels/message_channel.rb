# app/channels/message_channel.rb
class MessageChannel < ApplicationCable::Channel
  def subscribed
    puts params[:chat_room_id]
    # Rails.logger.info "Subscribed to chat room: #{params[:chat_room_id]}"
    
    # puts "Subscribed to chat room: #{params[:chat_room_id]}"
    @chat_room = ChatRoom.find(params[:chat_room_id])
    stream_for @chat_room.id
  end
  

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
