class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session

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

  def render_unauthorized!
    render json: { errors: [ I18n.t('errors.unauthorized') ] }, status: :unauthorized
  end

  def render_unprocessable_entity!(errors)
    render json: { errors: errors }, status: :unprocessable_entity
  end

  def render_ok!(res)
    render json: res, status: :ok
  end

  def render_created!(model, location)
    if location
      response.location = location
    end

    render json: model, status: :created
  end

  def render_no_content!
    head :no_content
  end
end
