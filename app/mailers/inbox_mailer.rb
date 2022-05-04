class InboxMailer < ApplicationMailer
  def inbox_email
    @user = params[:user]
    @newsletter_messages = NewsletterMessage.where(user: @user).where(created_at: (@user.last_inbox_at..@user.next_inbox_at)).order(created_at: :desc)

    if @newsletter_messages.count > 0
      @user.update(last_inbox_at: Time.zone.now, next_inbox_at: user.preference.next_inbox_at)

      mail(to: @user.email, subject: "Here is your #{@user.preference.period} mailpouch!")
    end
  end
end
