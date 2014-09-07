class Api::V1::SessionsController < ApplicationController
  respond_to :json

  skip_before_action :authenticate_with_token!, only: [:create]

  def create
    @current_user = Session::LogUserIn.with_credentials(credentials)

    if current_user
      render json: { token: current_user.token }, status: :ok
    else
      unauthorized!
    end
  end

  def destroy
    Session::LogUserOut.call

    render json: {}, status: :ok
  end

  private

  def credentials
    {
      email: params[:credentials] && params[:credentials][:email]
      #password: params[:credentials][:email]
    }
  end
end
