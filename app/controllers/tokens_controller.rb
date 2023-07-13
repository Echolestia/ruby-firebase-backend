class TokensController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      # Set token to expire in 24 hours
      token_payload = {
        user_id: user.id,
        exp: (Time.now + 24.hours).to_i
      }
      token = JWT.encode(token_payload, Rails.application.secret_key_base, 'HS256')
      render json: { status: 'Logged in', token: token, user_id: user.id }, status: :ok
    else
      render json: { error: 'Invalid email/password combination' }, status: :unprocessable_entity
    end
  end

  private

  def token_params
    params.require(:token).permit(:email, :password)
  end
end
