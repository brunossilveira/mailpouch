class AddInboxJobIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :inbox_job_id, :string
  end
end
