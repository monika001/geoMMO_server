class Session
  class << self
    def authenticate_user_with_token(token)
      # TODO
      # Its just for testing purpose
      # ############################
      # ############################
      if token == 'sample'
        user = User.find_by(email: 'sample@sample.co')
        if user.nil?
          user = User.create(email: 'sample@sample.co', password: 'haslo123', password_confirmation: 'haslo123')
        end
        store['sample'] = user
      end
      # ############################
      # ############################

      store[token]
    end

    def authenticate_user_with_credentials(credentials)
      return unless credentials && credentials[:email] && credentials[:password]

      email = credentials[:email]
      password = credentials[:password]

      user = User.find_by(email: email)
      user && user.authenticate(password) and
        token = regenerate_token(user) and
          [user, token]
    end

    def regenerate_token(user)
      return unless user

      delete_user_from_session(user)
      add_user_to_session(user)
    end

    def destroy_token(user)
      delete_user_from_session(user)
    end
  end

  private

  class << self
    def store
      @@store ||= {}
    end

    def token_of(user)
      tokens_of(user).first
    end

    def tokens_of(user)
      store.select { |_, v| v == user }.keys
    end

    def delete_user_from_session(user)
      tokens_of(user).each { |k| store.delete(k) }
    end

    def add_user_to_session(user)
      begin
        token = SecureRandom.base64
      end while store[token] != nil

      store[token] = user
      token
    end
  end
end
