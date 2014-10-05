class Location < ActiveRecord::Base
  belongs_to :character

  scope :nerby, ->(location) { where.not(id: location.id) }
end
