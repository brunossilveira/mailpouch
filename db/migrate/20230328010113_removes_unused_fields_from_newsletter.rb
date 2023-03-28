class RemovesUnusedFieldsFromNewsletter < ActiveRecord::Migration[7.0]
  def change
    remove_column :newsletters, :email
  end
end
