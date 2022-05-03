class InboxMailer < ApplicationMailer
  def inbox_email(user, newsletter_messages)
    @user = user
    @newsletter_messages = newsletter_messages

    mail(to: @user.email, subject: "Here is your #{@user.preference.period} mailpouch!")
  end
end
