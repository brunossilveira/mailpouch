module NewsletterMessages
  class Body
    attr_reader :mail

    def initialize(mail)
      @mail = mail
    end

    def unparsed
      mail.html_part.body
    end

    def text
      mail.text_part&.body
    end

    def parsed
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

      ::Sanitize.fragment(unparsed, options)
    end

    def raw
      ::Sanitize.fragment(unparsed, Sanitize::Config::RESTRICTED)
    end
  end
end
