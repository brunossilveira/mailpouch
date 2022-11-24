class InboxMailbox < ApplicationMailbox
  def process
    username = mail.to.first.split("@").first
    user = User.find_by(username: username)

    if user
      body = mail.html_part.body
      body_text = mail.text_part.body

      subject = mail.subject
      unsubscribe_header = mail.header['List-Unsubscribe']
      newsletter_name = mail[:from].addrs.first.display_name
      email = mail.from.first
      domain = email.split('@').last
      unsubscribe_url = unsubscribe_header.field.value.split(',').first.delete('<').delete('>') if unsubscribe_header
      newsletter = Newsletter.find_by(email: domain, user: user) || Newsletter.find_or_create_by(email: domain, name: newsletter_name, user: user)

      NewsletterMessage.create(user: user, newsletter: newsletter, subject: mail.subject, body: body, body_parsed: body_parsed(body), body_raw: body_raw(body), body_text: body_text, unsubscribe_url: unsubscribe_url)
    end
  end

  def body_parsed(body)
    options = {
      elements: %w[a p strong ul li ol img br b hr h1 h2 h3 h4],
      attributes: {
        'a' => %w[href title],
        'img' => %w[alt src title width height]
      },
      protocols: {
        'a' => {'href' => ['http', 'https', 'mailto']}
      },
      add_attributes: {
        'a' => {'rel' => 'nofollow'}
      }
    }

    ::Sanitize.fragment(body, options)
  end

  def body_raw(body)
    ::Sanitize.fragment(body, Sanitize::Config::RESTRICTED)
  end
end
