class AddNextInboxAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :next_inbox_at, :datetime, default: nil
  end
end
