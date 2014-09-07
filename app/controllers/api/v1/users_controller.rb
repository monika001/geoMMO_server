class Api::V1::UsersController < ApplicationController
  respond_to :json

  skip_before_action :authenticate_with_token!, only: [:create]

  def create
    obj = {}
    render json: obj, status: :ok
  end
end
