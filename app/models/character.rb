class Character < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :user, presence: true

  belongs_to :user
end
