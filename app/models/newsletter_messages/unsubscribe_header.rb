module NewsletterMessages
  class UnsubscribeHeader
    attr_reader :header

    def initialize(mail)
      @header = mail.header['List-Unsubscribe']
    end

    def url
      return nil unless header

      header_value.split(',').first.delete('<').delete('>')
    end

    private

    def header_value
      header.field.value
    end
  end
end
