class Session::LogUserIn
  class << self
    def with_credentials(credentials)
      Session.instance.authenticate_user_with_credentials(credentials)
    end

    def with_token(token)
      Session.instance.authenticate_user_with_token(token)
    end
  end
end