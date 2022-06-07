class ApplicationMailer < ActionMailer::Base
  default from: "inbox@mailpouch.app"
  layout "mailer"
end
