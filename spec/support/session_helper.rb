module Support
  module SessionHelper
    def log_in(user)
      user.regenerate_token

      token = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
      request.headers['Authorization'] = token
    end
  end
end
