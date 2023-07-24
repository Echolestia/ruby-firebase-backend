# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { User.find_by(email: "user1@email.com") }
  
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
    it "returns a success response (status 200) when provided with a valid user id" do
      get :show, params: { id: user.id }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
  
  describe "POST #create" do
    context "with valid params" do
      let(:valid_user_params) {
        { email: 'new_user@email.com', password: 'password123' }
      }

      it "creates a new User and returns a created (status 201) response" do
        expect {
          post :create, params: { user: valid_user_params }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end
    
    context "with invalid params such as required attribute equal to nil" do
      it "does not create a new user and returns an unprocessable entity (status 422) response" do
        post :create, params: { user: { email: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { email: 'new_email@test.com' }
      }

      it "updates the requested user's email and returns a success response (status 200)" do
        put :update, params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.email).to eq('new_email@test.com')
        expect(response).to have_http_status(200)
      end
    end
    
    context "with invalid params such as required attribute equal to nil" do
      it "does not update the user and returns an unprocessable entity (status 422) response" do
        put :update, params: { id: user.to_param, user: { email: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user and changes the User count by -1" do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end
  end
end
