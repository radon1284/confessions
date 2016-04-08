class SendLoginLink
  EXPIRATION_PERIOD = 24.hours

  def self.build
    new
  end

  def call(user)
    expires = EXPIRATION_PERIOD.from_now
    payload = { user_id: user.id }
    token = SecureToken.encode(payload, "login_link", expires)
    LoginMailer.login_link(user, token).deliver_now
  end
end
