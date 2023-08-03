# spec/channels/application_cable/connection_spec.rb

require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:user) { create(:user) }
  let(:token) { 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3NywiZXhwIjoxNjkxMTI0NDEwfQ.x32oXiQ3use3UYNNyNJEdOnIXwpJIjEAjRHSWgDSv-A' }
  
  context 'with valid token' do
    before do
      allow(JWT).to receive(:decode).and_return([{"user_id" => user.id}])
      connect "/cable", headers: { 'Authorization' => token }
    end

    it 'successfully connects' do
      expect(connection.current_user).to eq(user)
    end
  end

#   context 'with invalid token' do
#     before do
#       allow(JWT).to receive(:decode).and_raise(JWT::DecodeError)
#       connect "/cable", params: { 'token' => token }
#     end

#     it 'rejects connection' do
#       expect { connection }.to have_rejected_connection
#     end
#   end
end
