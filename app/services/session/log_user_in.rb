class Session::LogUserIn
  class << self
    def with_credentials(credentials)
      return unless credentials && credentials[:email] && credentials[:password]

      email = credentials[:email]
      password = credentials[:password]

      user = User.find_by(email: email)
      user && user.authenticate(password) and
        token = user.regenerate_token and
          [user, token]
    end

    def with_token(token)
      return unless token

      # --------------------------
      # --------------------------
      if token == 'sample'
        user = User.find_by(email: 'sample@sample.co')
        if user.nil?
          user = User.create(email: 'sample@sample.co', password: 'haslo123', password_confirmation: 'haslo123')
        end
        return user
      end
      # --------------------------
      # --------------------------
      # TODO: Just for tests

      User.find_by(token: token)
    end
  end
end
