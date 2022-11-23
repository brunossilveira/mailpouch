class AddBodyFieldsToNewsletterMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletter_messages, :body_raw, :text
    add_column :newsletter_messages, :body_parsed, :text
  end
end
