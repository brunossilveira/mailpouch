class CreateUserPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :user_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.string :period
      t.string :on
      t.string :at

      t.timestamps
    end
  end
end
