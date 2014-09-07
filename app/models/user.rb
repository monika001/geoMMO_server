class User < ActiveRecord::Base
  validates :email, uniqueness: true

  def self.authenticate(email)
    User.find_by(email: email)
  end
end
