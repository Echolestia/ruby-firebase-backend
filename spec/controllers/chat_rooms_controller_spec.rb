require 'rails_helper'

RSpec.describe ChatRoomsController, type: :controller do
  let!(:user) { User.find_by(email: "user1@email.com") }
  let!(:chat_room) { ChatRoom.find_by(user1_id: user.id) }
  
  before do
    request.headers['Authorization'] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3NywiZXhwIjoxNjkxMTI0NDEwfQ.x32oXiQ3use3UYNNyNJEdOnIXwpJIjEAjRHSWgDSv-A"
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
    it "returns a success response (status 200) when provided with a valid chat room id" do
      get :show, params: { id: chat_room.id }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #chat_rooms_for_user" do
    it "returns a success response (status 200) and the chat rooms for the given user id" do
      get :chat_rooms_for_user, params: { user_id: user.id }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET #show_with_messages" do
    it "returns a success response (status 200) and the chat room along with its messages for a given chat room id" do
      get :show_with_messages, params: { id: chat_room.id }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_chat_room_params) {
        { user1_id: user.id, user2_id: User.last.id, overall_sentiment_analysis_score: 0.0, date_created: Time.now, is_ai_chat: false, is_group_chat: false }
      }

      it "creates a new ChatRoom and returns a created (status 201) response" do
        expect {
          post :create, params: { chat_room: valid_chat_room_params }
        }.to change(ChatRoom, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end
    
    context "with invalid params such as required attribute equal to nil" do
      it "does not create a new chat room and returns an unprocessable entity (status 422) response" do
        post :create, params: { chat_room: { user1_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { is_ai_chat: true }
      }

      it "updates the requested chat room's is_ai_chat attribute and returns a success response (status 200)" do
        put :update, params: { id: chat_room.to_param, chat_room: new_attributes }
        chat_room.reload
        expect(chat_room.is_ai_chat).to eq(true)
        expect(response).to have_http_status(200)
      end
    end
    
    context "with invalid params such as required attribute equal to nil" do
      it "does not update the chat room and returns an unprocessable entity (status 422) response" do
        put :update, params: { id: chat_room.to_param, chat_room: { user1_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested chat room and changes the ChatRoom count by -1" do
      expect {
        delete :destroy, params: { id: chat_room.id }
      }.to change(ChatRoom, :count).by(-1)
    end
  end

  ## pm4 stuff
  describe "POST #create" do
    # boundary value testing
    context "with boundary case params" do
      let(:boundary_chat_room_params) {
        { user1_id: user.id, user2_id: User.last.id, overall_sentiment_analysis_score: 0.0, date_created: Time.now, is_ai_chat: false, is_group_chat: false }
      }
  
      it "creates a new ChatRoom with boundary overall_sentiment_analysis_score and returns a created (status 201) response" do
        expect {
          post :create, params: { chat_room: boundary_chat_room_params }
        }.to change(ChatRoom, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end
  
    # ROBUST boundary value testing
    context "with out of boundary case params" do
      let(:out_of_bounds_chat_room_params) {
        { user1_id: user.id, user2_id: User.last.id, overall_sentiment_analysis_score: -0.1, date_created: Time.now, is_ai_chat: false, is_group_chat: false }
      }
  
      it "does not create a new ChatRoom with out of bounds overall_sentiment_analysis_score and returns an unprocessable entity (status 422) response" do
        expect {
          post :create, params: { chat_room: out_of_bounds_chat_room_params }
        }.not_to change(ChatRoom, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    # boundary value testing
    context "with boundary case params" do
      let(:boundary_attributes) {
        { overall_sentiment_analysis_score: 1.0 }
      }
  
      it "updates the requested chat room's overall_sentiment_analysis_score to boundary value and returns a success response (status 200)" do
        put :update, params: { id: chat_room.to_param, chat_room: boundary_attributes }
        chat_room.reload
        expect(chat_room.overall_sentiment_analysis_score).to eq(1.0)
        expect(response).to have_http_status(200)
      end
    end
  
    # robust boundary value testing
    context "with out of boundary case params" do
      let(:out_of_bounds_attributes) {
        { overall_sentiment_analysis_score: 1.1 }
      }
  
      it "does not update the chat room's overall_sentiment_analysis_score to out of bounds value and returns an unprocessable entity (status 422) response" do
        put :update, params: { id: chat_room.to_param, chat_room: out_of_bounds_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  
end
