class CreateNewsletterSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :newsletter_subscriptions do |t|
      t.references :newsletter, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
