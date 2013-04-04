helpers do
  def valid_password?(user, password)
    user.password_hash == BCrypt::Engine.hash_secret(password, user.salt)
  end

  def login?
    session[:current_user_id] ? true : false
  end
end
