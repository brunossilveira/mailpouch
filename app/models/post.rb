class Post < ApplicationRecord
  extend FriendlyId

  friendly_id :slug

  validates :title, :content, :slug, presence: true

  scope :published, -> { where('published_at <= ?', Time.zone.now) }
end
