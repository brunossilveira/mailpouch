class AddsSentConversionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :sent_conversion, :boolean, default: false
  end
end
