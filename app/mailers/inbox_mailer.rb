class InboxMailer < ApplicationMailer
  def inbox_email
    @user = params[:user]
    @newsletter_messages = params[:newsletter_messages]

    mail(to: @user.email, subject: "Your inbox")
  end
end
