class Newsletter < ApplicationRecord
  belongs_to :user

  def unsubscribe_url
    NewsletterMessage.where(newsletter: self).last.unsubscribe_url
  end
end
