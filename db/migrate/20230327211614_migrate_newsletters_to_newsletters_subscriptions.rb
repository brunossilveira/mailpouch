class MigrateNewslettersToNewslettersSubscriptions < ActiveRecord::Migration[7.0]
  def up
    Newsletter.find_each do  |newsletter|
      NewsletterSubscription.create(newsletter: newsletter, user: newsletter.user)
    end
  end
end
