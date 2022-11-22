class ApplicationMailer < ActionMailer::Base
  default from: "Mailpouch <inbox@mailpouch.app>"
  layout "mailer"
end
