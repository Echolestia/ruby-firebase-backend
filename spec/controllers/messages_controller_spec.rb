# spec/controllers/messages_controller_spec.rb
require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let!(:message) { Message.find_by(sentiment_analysis_score: 0.85) }
  puts :message

  before do
    request.headers['Authorization'] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3NywiZXhwIjoxNjkwMTc4Njg1fQ.RaI1ml2JGvk9R08yYgj9Hx5RXw3-j4w4_lx0okgLVIA"
  end

  describe "GET #index" do
    it "returns a success response (status 200) and should not be empty" do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end
  
  describe "GET #show" do
    it "returns a success response (status 200) when provided with a valid message id" do
      get :show, params: { id: message.id }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
  
  describe "POST #create" do
    context "with valid params" do
      let(:valid_message_params) {
        { read: false, sender_id: 1, receiver_id: 2, timestamp: Time.now, sentiment_analysis_score: 0.85, content: "New message", message_type: 'text', chat_room_id: 1 }
      }

      it "creates a new Message and returns a created (status 201) response" do
        expect {
          post :create, params: { message: valid_message_params }
        }.to change(Message, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end
    
    context "with invalid params such as missing required attribute" do
      it "does not create a new message and returns an unprocessable entity (status 422) response" do
        post :create, params: { message: { content: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { content: 'Updated message content' }
      }

      it "updates the requested message's content and returns a success response (status 200)" do
        put :update, params: { id: message.to_param, message: new_attributes }
        message.reload
        expect(message.content).to eq('Updated message content')
        expect(response).to have_http_status(200)
      end
    end
    
    context "with invalid params such as missing required attribute" do
      it "does not update the message and returns an unprocessable entity (status 422) response" do
        put :update, params: { id: message.to_param, message: { content: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested message and changes the Message count by -1" do
      expect {
        delete :destroy, params: { id: message.id }
      }.to change(Message, :count).by(-1)
    end
  end
end
