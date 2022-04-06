class InboxMailbox < ApplicationMailbox
  def process
    username = mail.to.first.split("@").first
    user = User.find_by(username: username)

    if user
      newsletter_name = mail[:from].addrs.first.display_name
      newsletter = Newsletter.find_or_create_by(email: mail.from.first, name: newsletter_name, user: user)
      NewsletterMessage.create(user: user, newsletter: newsletter, subject: mail.subject, body: mail.html_part.body)
    end
  end
end
