# spec/controllers/tokens_controller_spec.rb

require 'rails_helper'

RSpec.describe TokensController, type: :controller do
  describe "POST #create" do
    let(:password) { 'password123' }
    let(:user) { create(:user, password: password, password_confirmation: password) }

    context "when provided with valid email and password" do
      it "logs in the user, returns a JWT token and the user's id, and responds with HTTP status 200 (OK)" do
        post :create, params: { email: user.email, password: password }
        json = JSON.parse(response.body)
        
        token = json['token']
        decoded_token = JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: 'HS256' })[0]
        
        expect(response).to have_http_status(:ok)
        expect(json['status']).to eq('Logged in')
        expect(json['user_id']).to eq(user.id)

        expect(decoded_token['user_id']).to eq(user.id)
        expect(decoded_token['exp']).to be > Time.now.to_i
      end
    end

    context "when provided with invalid email or password" do
      it "does not log in the user, returns an error message, and responds with HTTP status 422 (unprocessable_entity)" do
        post :create, params: { email: user.email, password: 'wrongpassword' }
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['error']).to eq('Invalid email/password combination')
      end
    end
  end
end
