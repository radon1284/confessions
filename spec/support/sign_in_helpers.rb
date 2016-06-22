module SignInHelpers
  def sign_in(user)
    token = SecureToken.encode(
      { user_id: user.id },
      "login_link",
      24.hours.from_now
    )
    visit authentication_authenticate_by_token_path(token: token)
  end

  def sign_in_admin
    username = ENV.fetch('ADMIN_NAME')
    password = ENV.fetch('ADMIN_PASSWORD')
    if page.driver.respond_to?(:authorize)
      page.driver.authorize(username, password)
    # Javascript driver fallback
    else
      basic = ActionController::HttpAuthentication::Basic
      credentials = basic.encode_credentials(username, password)
      page.driver.header('Authorization', credentials)
    end
  end
end
