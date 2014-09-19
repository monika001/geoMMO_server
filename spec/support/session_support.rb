module Support
  module SessionSupport
    def session_length
      Session.send(:store).length
    end

    def token_of(user)
      Session.send(:token_of, user)
    end

    def add_user_to_session(user)
      Session.send(:add_user_to_session, user)
    end

    def add_token_to_header_of(user)
      request.headers['HTTP_USER_API_TOKEN'] = token_of(user)
    end

    def log_in_and_set_header(user)
      add_user_to_session(user)
      add_token_to_header_of(user)
    end
  end
end
