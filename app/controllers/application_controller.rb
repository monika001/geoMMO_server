class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :authenticate_with_token!

  protected

  def current_user
    @current_user
  end

  def authenticate_with_token!
    token = request.headers['HTTP_USER_API_TOKEN']
    @current_user = Session::LogUserIn.with_token(token) or unauthorized!
  end

  def unauthorized!
    render json: {}, status: :unauthorized
  end
end
