class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness:{ case_sensitive: false }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password_confirmation, presence: true, on: :create

  def authenticate(password)
    user = super

    return nil unless user
    user
  end
end
