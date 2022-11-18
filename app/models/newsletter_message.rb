class NewsletterMessage < ApplicationRecord
  belongs_to :newsletter
  belongs_to :user

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }

  def self.inbox_messages_by(user:)
    NewsletterMessage.where(user: user).unread.where(created_at: (user.last_inbox_at..Time.zone.now).order(created_at: :desc)
  end
end
