# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { User.find_by(email: "user1@email.com") }
  
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

  ## PM 4 STUFF

    # Extend POST #create
  describe "POST #create" do
    # Boundary value testing
    context "with boundary case params" do
      let(:max_length_string) { "a" * 255 }  # Email max length in most cases

      let(:boundary_user_params) {
        {
          email: max_length_string,
          password: 'password123'
        }
      }

      it "creates a new User with max length email and returns a created (status 201) response" do
        expect {
          post :create, params: { user: boundary_user_params }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end

    # Robust boundary value testing
    context "with out of boundary case params" do
      let(:out_of_bounds_string) { "a" * 256 }  # Exceeding email max length

      let(:out_of_bounds_user_params) {
        {
          email: out_of_bounds_string,
          password: 'password123'
        }
      }

      it "does not create a new User with out of bounds length email and returns an unprocessable entity (status 422) response" do
        expect {
          post :create, params: { user: out_of_bounds_user_params }
        }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    # Worst case testing
    context "with worst case params (empty params)" do
      it "does not create a new User and returns an unprocessable entity (status 422) response" do
        post :create
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # Extend PUT #update
  describe "PUT #update" do
    context "with boundary case params" do
      let(:max_length_string) { "a" * 255 }

      it "updates the requested user's email to max length and returns a success response (status 200)" do
        put :update, params: { id: user.to_param, user: { email: max_length_string } }
        user.reload
        expect(user.email).to eq(max_length_string)
        expect(response).to have_http_status(200)
      end
    end

    context "with out of boundary case params" do
      let(:out_of_bounds_string) { "a" * 256 }

      it "does not update the user's email to out of bounds length and returns an unprocessable entity (status 422) response" do
        put :update, params: { id: user.to_param, user: { email: out_of_bounds_string } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    # Worst case testing
    context "with worst case params (empty params)" do
      it "does not update the user and returns an unprocessable entity (status 422) response" do
        put :update, params: { id: user.to_param, user: {} }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  ## FUZZER TEST
  describe "POST #create - Fuzzer Test" do
    context "with random data" do
      let(:random_string) { (0...50).map { ('a'..'z').to_a[rand(26)] }.join }
      let(:random_email) { "#{random_string}@#{random_string}.com" }
  
      let(:fuzz_user_params) {
        {
          email: random_email,
          password: random_string
        }
      }
  
      it "handles random input data gracefully" do
        # Logging the generated input
        puts "\nGenerated user fuzz test input: #{fuzz_user_params} \n------\n"
  
        post :create, params: { user: fuzz_user_params }
  
        # Logging the server response
        puts "Server response: #{response.body}\n"
  
        expect(response.status).not_to eq(500)
      end
    end
  end
  

end
