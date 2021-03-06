class Api::V1::UsersController < ApplicationController
  respond_to :json
  skip_before_action :authenticate_with_token!, only: [:create]

  def show
    render_ok! current_user
  end

  def create
    user = User.new(user_params)

    if user.save
      render_created! user, api_v1_user_path
    else
      render_unprocessable_entity! user.errors.full_messages
    end
  end

  def update
    if current_user.update(user_params)
      render_no_content!
    else
      render_unprocessable_entity! current_user.errors.full_messages
    end
  end

  def destroy
    Session::LogUserOut.call(current_user)
    current_user.destroy

    render_no_content!
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :first_name, :last_name, :password, :password_confirmation)
  end
end
