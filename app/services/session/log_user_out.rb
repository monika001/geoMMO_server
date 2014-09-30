class Session::LogUserOut
  class << self
    def call(user)
      Session.destroy_token(user)
    end
  end
end
