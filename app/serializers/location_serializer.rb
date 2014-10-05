class LocationSerializer < ActiveModel::Serializer
  attributes :id, :longitude, :latitude

  has_one :character
end
