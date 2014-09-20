class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #
  protect_from_forgery with: :null_session

  before_action :authenticate_with_token!

  protected

  def current_user
    @current_user
  end

  def authenticate_with_token!
    authenticate_with_http_token do |token, _|
      @current_user = Session::LogUserIn.with_token(token)
    end or render_unauthorized!
  end

  def render_unauthorized!(res = {})
    render json: res, status: :unauthorized
  end

  def render_unprocessable_entity!(res = {})
    render json: res, status: :unprocessable_entity
  end

  def render_ok!(res = {})
    render json: res, status: :ok
  end

  def render_created!(res = {})
    render json: res, status: :created
  end
end
