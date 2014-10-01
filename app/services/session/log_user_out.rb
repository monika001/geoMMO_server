class Session::LogUserOut
  class << self
    def call(user)
      user.destroy_token
    end
  end
end
