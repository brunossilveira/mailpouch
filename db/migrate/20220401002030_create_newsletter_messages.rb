class CreateNewsletterMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :newsletter_messages do |t|
      t.references :newsletter, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :body
      t.string :subject

      t.timestamps
    end
  end
end
