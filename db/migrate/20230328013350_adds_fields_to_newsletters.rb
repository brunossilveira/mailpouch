class AddsFieldsToNewsletters < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletters, :tags, :string, array: true
    add_column :newsletters, :tagline, :string
    add_column :newsletters, :description, :string
    add_column :newsletters, :frequency, :string
    add_column :newsletters, :subscribe_url, :string
    add_column :newsletters, :subscribers_count, :integer
  end
end
