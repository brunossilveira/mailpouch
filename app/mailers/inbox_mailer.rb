class InboxMailer < ApplicationMailer
  def inbox_email
    @user = params[:user]
    @newsletter_messages = params[:newsletter_messages]

    mail(to: @user.email, subject: "Here is your #{@user.preference.period} mailpouch!")
  end
end
