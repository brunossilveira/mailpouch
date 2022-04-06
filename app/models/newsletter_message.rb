class NewsletterMessage < ApplicationRecord
  belongs_to :newsletter
  belongs_to :user

  def logo_src
    html = Nokogiri::HTML(body)

    src = html.css('img').map do |l|
      src = l.attr('src')
      src unless src&.include? 'gif'
    end.compact.first
  end
end
