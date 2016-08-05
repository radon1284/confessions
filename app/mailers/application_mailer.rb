class ApplicationMailer < ActionMailer::Base
  default from: ENV["OUR_EMAIL"],
          reply_to: ENV["OUR_EMAIL"]
  layout 'mailer'
end
