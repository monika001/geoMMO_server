require "singleton"

class Session
  include Singleton

  def initialize
    @store = {}
  end

  def authenticate_user_with_token(token)
    store[token]
  end

  def authenticate_user_with_credentials(credentials)
    return unless credentials && credentials[:email]

    user = User.authenticate(credentials[:email])
    regenerate_token user

    user
  end

  def regenerate_token(user)
    return unless user

    delete_user_from_session user
    add_user_to_session user
  end

  def destroy_token(user)
    delete_user_from_session user
  end

  private

  def store
    @store
  end

  def token_of(user)
    tokens_of(user).first
  end

  def tokens_of(user)
    store.select { |_,v| v == user }.keys
  end

  def delete_user_from_session(user)
    tokens_of(user).each { |k| store.delete(k) }
  end

  def add_user_to_session(user)
    token = SecureRandom.base64
    store[token] = user
    token
  end
end
