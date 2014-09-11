class Api::V1::UsersController < ApplicationController
  respond_to :json

  skip_before_action :authenticate_with_token!, only: [:create]

  def create
    return render_bad_request! unless credentials[:email]

    user = User.new email: credentials[:email]
    if user.save
      render_created!
    else
      render_unprocessable_entity!
    end
  end

  private

  def credentials
    {
      email: params[:user] && params[:user][:email]
    }
  end
end
