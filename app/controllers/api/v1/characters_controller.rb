class Api::V1::CharactersController < ApplicationController
  respond_to :json

  def create
    new_character = Character.new model_params
    new_character.user = current_user

    if new_character.save
      render_created! new_character, api_v1_character_path(new_character)
    else
      render_unprocessable_entity! new_character.errors.full_messages
    end
  end

  def update
    if character.update(model_params)
      render_no_content!
    else
      render_unprocessable_entity! character.errors.full_messages
    end
  end

  def destroy
    character.destroy
    render_no_content!
  end

  private

  def model_params
    params.require(:character).permit(:name)
  end

  def character
    @character ||= current_user.characters.find_by id: params[:id]
  end
end
