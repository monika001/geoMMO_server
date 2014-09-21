class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness:{ case_sensitive: false }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password, presence: true

  def self.authenticate(email, password)
    return unless user = User.find_by(email: email)

    user.authenticate password
  end
end
