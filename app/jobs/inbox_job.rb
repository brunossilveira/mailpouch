class InboxJob < ApplicationJob
  def perform
    User.find_each do |user|
      return if !user.should_send_newsletter?

      newsletter_messages = NewsletterMessage.where(user: user).where(created_at: (user.last_inbox_at..user.next_inbox_at)).order(created_at: :desc)

      if newsletter_messages.count > 0
        user.update(last_inbox_at: Time.zone.now, next_inbox_at: user.preference.next_inbox_at)
        InboxMailer.with(user: user, newsletter_messages: newsletter_messages).inbox_email
      end
    end
  end
end
