class AddUnsubscribeUrlToNewsletterMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletter_messages, :unsubscribe_url, :string
  end
end
