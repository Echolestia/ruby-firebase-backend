class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      render json: { status: 'Logged in', user_id: user.id }, status: :ok
    else
      render json: { error: 'Invalid email/password combination' }, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    render json: { status: 'Logged out' }, status: :ok
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
