module Support
  module SessionSupport
    def session_length
      Session.instance.send(:store).length
    end

    def token_of(user)
      Session.instance.send(:token_of, user)
    end

    def add_user_to_session(user)
      Session.instance.send(:add_user_to_session, user)
    end
  end
end
