class SessionsController < ApplicationController
  before_action :authorize, only: [:destroy]

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      render json: user, status: :created
      session[:user_id] = user.id
    else
      render json: { errors: ["Not authorized"] }, status: :unauthorized
    end
  end

  def destroy
    session.delete :user_id
    head :no_content
  end


end
