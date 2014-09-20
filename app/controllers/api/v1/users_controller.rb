class Api::V1::UsersController < ApplicationController
  respond_to :json
  skip_before_action :authenticate_with_token!, only: [:create]

  def create
    user = User.new(user_params)

    if user.save
      id = user.id
      uri = api_v1_user_url user

      render_created! id: id, uri: uri, type: 'user'
    else
      render_unprocessable_entity!(user.errors)
    end
  end

  def destroy
    Session::LogUserOut.call(current_user)

    if current_user.destroy
      render_ok! email: current_user.email, message: 'successfully deleted'
    else
      render_unprocessable_entity!
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :email)
  end
end
