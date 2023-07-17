class Post < ApplicationRecord
  extend FriendlyId

  friendly_id :slug

  validates :title, :content, :slug, presence: true
end
