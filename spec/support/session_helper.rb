module Support
  module SessionHelper
    def add_user_to_session(user)
      user.regenerate_token
    end

    def add_token_to_header_of(user)
      token = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
      request.headers['Authorization'] = token
    end

    def log_in(user)
      add_user_to_session(user)
      add_token_to_header_of(user)
    end
  end
end
