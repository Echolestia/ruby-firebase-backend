module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.username
    end

    protected

    def find_verified_user
      # Get the authorization token from the headers
      token = request.params[:token]
      puts "Token: #{token}"  # Print out the token value
    
      decoded_token = JWT.decode token, Rails.application.secret_key_base, true, { algorithm: 'HS256' }
      puts "Decoded Token: #{decoded_token}"  # Print out the decoded token
    
      if current_user = User.find(decoded_token[0]["user_id"])
        current_user
      else
        reject_unauthorized_connection
      end
    rescue
      reject_unauthorized_connection
    end
  end
end
