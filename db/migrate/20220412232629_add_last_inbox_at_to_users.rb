class AddLastInboxAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_inbox_at, :datetime
  end
end
