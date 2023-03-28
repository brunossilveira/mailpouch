class NewsletterSubscription < ApplicationRecord
  belongs_to :newsletter
  belongs_to :user

  delegate :email, :name, to: :newsletter

  def unsubscribe_url
    NewsletterMessage.where(newsletter: newsletter).last&.unsubscribe_url
  end
end
