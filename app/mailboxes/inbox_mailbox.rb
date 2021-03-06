class InboxMailbox < ApplicationMailbox
  def process
    username = mail.to.first.split("@").first
    user = User.find_by(username: username)

    if user
      subject = mail.subject
      unsubscribe_header = mail.header['List-Unsubscribe']
      newsletter_name = mail[:from].addrs.first.display_name
      email = mail.from.first
      domain = email.split('@').last
      unsubscribe_url = unsubscribe_header.field.value.split(',').first.delete('<').delete('>') if unsubscribe_header
      newsletter = Newsletter.find_by(email: email) || Newsletter.find_or_create_by(email: email, name: newsletter_name, user: user)

      NewsletterMessage.create(user: user, newsletter: newsletter, subject: mail.subject, body: mail.html_part.body, unsubscribe_url: unsubscribe_url)
    end
  end
end
