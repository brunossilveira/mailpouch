class NewsletterMessage < ApplicationRecord
  belongs_to :newsletter
  belongs_to :user
end
