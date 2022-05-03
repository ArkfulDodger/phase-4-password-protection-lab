class UsersController < ApplicationController
  # POST /signup
  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user
  end

  # GET /me
  def show
    user = User.find_by(id: session[:user_id])
    if user
      render json: user
    else
      render json: { error: 'Not logged in' }, status: :unauthorized
    end
  end

  private

  # permissible params to be used by create/update
  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
