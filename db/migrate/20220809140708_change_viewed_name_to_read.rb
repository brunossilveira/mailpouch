class ChangeViewedNameToRead < ActiveRecord::Migration[7.0]
  def change
    rename_column :newsletter_messages, :viewed, :read
  end
end
