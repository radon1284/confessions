module SignInHelpers
  def sign_in(user)
    token = SecureToken.encode(
      { user_id: user.id },
      "login_link",
      24.hours.from_now
    )
    visit authentication_authenticate_by_token_path(token: token)
  end
end
