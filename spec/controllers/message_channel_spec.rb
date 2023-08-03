require 'rails_helper'
require 'action_cable/testing/rspec'

RSpec.describe MessageChannel, type: :channel do
let!(:user) { User.find_by(email: "user1@email.com") }
  let!(:chat_room) { ChatRoom.find_by(user1_id: user.id) }
  let(:token) { 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3NywiZXhwIjoxNjkxMTI0NDEwfQ.x32oXiQ3use3UYNNyNJEdOnIXwpJIjEAjRHSWgDSv-A' }



  # before do
  #   # Use stubs to avoid making a call to User.find with the decoded token
  #   puts "Chat Room ID: #{user.id} #{chat_room.id}"
  #   allow(User).to receive(:find).and_return(user)
  #   stub_connection current_user: user, params: { token: token }
  # end

  describe '#subscribed' do
    it 'successfully subscribes and streams for chat_room' do
      # puts "Chat Room ID: #{chat_room.id}"
      subscribe(chat_room_id: chat_room.id)

      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_for(chat_room.id)
    end
  end

  describe '#unsubscribed' do
    it 'successfully unsubscribes' do
      subscribe(chat_room_id: chat_room.id)
      unsubscribe

      expect(subscription).not_to have_stream_for(chat_room.id)
    end
  end
end
