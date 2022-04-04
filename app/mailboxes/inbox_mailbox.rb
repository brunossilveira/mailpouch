class InboxMailbox < ApplicationMailbox
  def process
    username = mail.to.first.split("@")[0]
    user = User.find_by(username: username)

    if user
      newsletter = Newsletter.find_or_create_by(email: mail.from)
      NewsletterMessage.create(user: user, newsletter: newsletter, subject: mail.subject, body: mail.html_part.body)
    end
  end
end
