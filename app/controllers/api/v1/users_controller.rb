class Api::V1::UsersController < ApplicationController
  respond_to :json
  skip_before_action :authenticate_with_token!, only: [:create]

  def create
    user = User.new(user_params)
    user.save ? render_created! : render_unprocessable_entity!
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
