class LoginMailer < ApplicationMailer
  def login_link(user, token)
    @token = token
    mail to: user.email
  end
end
