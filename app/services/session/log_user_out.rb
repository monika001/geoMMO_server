class Session::LogUserOut
  class << self
    def call(user)
      Session.instance.destroy_token(user)
    end
  end
end
