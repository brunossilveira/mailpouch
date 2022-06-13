# Preview all emails at http://localhost:3000/rails/mailers/inbox_mailer
class InboxMailerPreview < ActionMailer::Preview
  def inbox_email
    InboxMailer.with(user: User.first, newsletter_messages: NewsletterMessage.all).inbox_email
  end
end
