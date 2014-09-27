class Api::V1::CharactersController < ApplicationController
  respond_to :json

  def create
    character = Character.new model_params
    character.user = current_user

    if character.save
      render_created! character, api_v1_character_path(character)
    else
      render_unprocessable_entity! character.errors.full_messages
    end
  end

  private

  def model_params
    params.require(:character).permit(:name)
  end
end
