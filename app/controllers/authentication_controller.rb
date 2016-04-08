class AuthenticationController < ApplicationController
  def login
  end

  def send_token
    user = User.find_by(email: params[:email])
    LoginLinkWorker.perform_async(user.id) if user.present?
    redirect_to(
      root_url,
      notice: t("authentication.login_link_sent")
    )
  end

  def authenticate_by_token
    result, payload = SecureToken.decode(params.fetch(:token), "login_link")
    case result
    when :ok
      session[:user_id] = payload.fetch(:user_id)
      redirect_to root_url, notice: t("authentication.login_successful")
    when :expired
      redirect_to root_url, flash: { error: t("authentication.link_expired") }
    when :invalid
      redirect_to root_url, flash: { error: t("authentication.link_invalid") }
    end
  end
end
