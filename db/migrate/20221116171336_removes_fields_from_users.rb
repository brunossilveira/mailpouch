class RemovesFieldsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :next_inbox_at
    remove_column :users, :inbox_job_id
  end
end
