class ReminderMailer < ApplicationMailer
  default from: "Mailpouch <bruno@mailpouch.app>"

  def reminder_email
    @user = params[:user]

    mail(to: @user.email, subject: "Don't forget to fill your Mailpouch!")
  end
end
