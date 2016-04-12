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
    page.driver.browser.authorize(
      ENV.fetch('ADMIN_NAME'),
      ENV.fetch('ADMIN_PASSWORD')
    )
  end
end
