class RemovesUserIdFromNewsletters < ActiveRecord::Migration[7.0]
  def change
    remove_column :newsletters, :user_id
  end
end
