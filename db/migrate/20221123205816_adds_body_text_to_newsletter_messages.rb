class AddsBodyTextToNewsletterMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletter_messages, :body_text, :text
  end
end
