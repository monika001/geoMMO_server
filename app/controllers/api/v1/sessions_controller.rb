class Api::V1::SessionsController < ApplicationController
  respond_to :json

  skip_before_action :authenticate_with_token!, only: [:create]

  def create
    @current_user, token = Session::LogUserIn.with_credentials(session_params)

    if current_user
      render_ok! session: { token: token }
    else
      render_login_error!
    end
  end

  def destroy
    Session::LogUserOut.call(current_user)
    render_no_content!
  end

  private

  def session_params
    {
      email: params[:session] && params[:session][:email],
      password: params[:session] && params[:session][:password]
    }
  end

  def render_login_error!
    render json: { errors: [ I18n.t('errors.login') ] }, status: :unauthorized
  end
end
