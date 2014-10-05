class Location < ActiveRecord::Base
  belongs_to :character

  scope :nearby, ->(location) { where.not(id: location.id) }
end
