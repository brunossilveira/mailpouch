class InboxMailbox < ApplicationMailbox
  def process
    Event.create(user: User.first, title: 'received_inbox', description: "From: #{mail.from.first} | To: #{mail.to.first}")

    username = mail.to.first.split("@").first
    user = User.find_by(username: username)

    if user
      body = NewsletterMessages::Body.new(mail)
      unsubscribe_header = NewsletterMessages::UnsubscribeHeader.new(mail)

      subject = mail.subject

      newsletter_name = mail[:from].addrs.first.display_name

      email = mail.from.first
      domain = email.split('@').last

      newsletter = Newsletter.find_or_create_with_name(domain: domain, user: user, name: newsletter_name)

      NewsletterMessage.create(
        user: user,
        newsletter: newsletter,
        subject: mail.subject,
        body: body.unparsed,
        body_parsed: body.parsed,
        body_raw: body.raw,
        body_text: body.text,
        unsubscribe_url: unsubscribe_header.url
      )
    end
  end
end
