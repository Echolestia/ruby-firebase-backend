class ApplicationController < ActionController::API
  before_action :authenticate

  def authenticate
    authorization_header = request.headers[:authorization]

    if authorization_header
      token = authorization_header.split(' ')[1]
      begin
        @current_user_id = JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: 'HS256' })[0]["user_id"]
      rescue JWT::DecodeError
        head :unauthorized
      end
    else
      head :unauthorized
    end
  end
end
