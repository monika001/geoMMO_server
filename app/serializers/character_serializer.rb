class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :name

  private
  def attributes
    hash = super
    hash.merge!(experience: object.experience) if owner?
    hash
  end

  def owner?
    scope == object.user
  end
end
