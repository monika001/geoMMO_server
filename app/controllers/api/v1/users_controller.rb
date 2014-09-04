class Api::V1::UsersController < ApplicationController
  respond_to :json

  def create
    obj = {}
    render json: obj, status: :ok
  end
end
