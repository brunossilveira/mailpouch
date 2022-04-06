class AddViewedToNewsletterMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletter_messages, :viewed, :boolean, default: false
  end
end
