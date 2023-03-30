class ReminderMailer < ApplicationMailer
  def reminder_email
    @user = params[:user]

    mail(to: @user.email, subject: "Don't forget to fill your Mailpouch!")
  end
end
