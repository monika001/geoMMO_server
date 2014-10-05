class Api::V1::LocationsController < ApplicationController
  respond_to :json

  before_action :test_bad_request

  def update
    character.location.update model_params
    render_no_content!
  end

  def show
    render_ok! character.location
  end

  def nerby
    render_ok! Location.nerby(character.location)
  end

  private

  def model_params
    params.require(:location).permit(:longitude, :latitude)
  end

  def test_bad_request
    render_bad_request! unless character
  end

  def character
    @character ||= current_user.characters.find_by id: params[:character_id]
  end
end
