class Newsletter < ApplicationRecord
  belongs_to :user

  def self.find_or_create_with_name(domain:, user:, name:)
    self.find_by(email: domain, user: user) ||
      self.find_or_create_by(email: domain, user: user, name: name)
  end

  def unsubscribe_url
    NewsletterMessage.where(newsletter: self).last.unsubscribe_url
  end
end
