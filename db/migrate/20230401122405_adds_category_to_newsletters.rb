class AddsCategoryToNewsletters < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletters, :category, :string
  end
end
