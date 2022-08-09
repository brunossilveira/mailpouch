class NewsletterMessage < ApplicationRecord
  belongs_to :newsletter
  belongs_to :user

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }
end
