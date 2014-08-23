class User < ActiveRecord::Base
  before_create :generate_accesss_token
  
  validates :token, :email, uniqueness: true

  private

  def generate_accesss_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?( token: token  )
  end
end
