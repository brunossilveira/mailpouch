class InboxMailbox < ApplicationMailbox
  def process
    username = mail.to.first.split("@").first
    user = User.find_by(username: username)

    if user
      body = NewsletterMessages::Body.new(mail)
      unsubscribe_header = NewsletterMessages::UnsubscribeHeader.new(mail)

      subject = mail.subject
      email = mail.from.first

      newsletter_name = mail[:from].addrs.first.display_name

      newsletter = Newsletter.find_or_create_by(name: newsletter_name)
      newsletter.update(email: email) unless newsletter.email.present?

      NewsletterSubscription.find_or_create_by(newsletter: newsletter, user: user)

      return if NewsletterMessage.exists?(newsletter: newsletter, subject: subject, user: user)

      NewsletterMessage.create(
        user: user,
        newsletter: newsletter,
        subject: subject,
        body: body.unparsed,
        body_parsed: body.parsed,
        body_raw: body.raw,
        body_text: body.text,
        unsubscribe_url: unsubscribe_header.url
      )
    end
  end
end
