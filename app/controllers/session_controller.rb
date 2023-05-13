class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = user.generate_jwt
      render json: { token: }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def show
    token = request.headers['Authorization'].split.last
    user = User.decode_jwt(token)
    render json: user
  end
end
