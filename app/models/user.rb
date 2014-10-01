class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness:{ case_sensitive: false }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password_confirmation, presence: true, on: :create

  has_many :characters, dependent: :destroy

  def authenticate(password)
    user = super

    return nil unless user
    user
  end

  def regenerate_token
    begin
      token = SecureRandom.base64
    end while self.class.exists?(token: token)

    update_attribute(:token, token)
    token
  end

  def destroy_token
    update_attribute :token, nil
  end
end
