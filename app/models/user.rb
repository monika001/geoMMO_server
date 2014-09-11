class User < ActiveRecord::Base
  validates :email, uniqueness:{ case_sensitive: false }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  def self.authenticate(email)
    User.find_by(email: email)
  end
end
