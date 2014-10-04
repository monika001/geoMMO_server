class Character < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :user, presence: true

  belongs_to :user
  has_one :location, dependent: :destroy

  after_create { create_location }

  private
end
