class FixesNewsletters < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletters, :email, :string
    remove_column :newsletters, :domain
  end
end
