class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.text :content
      t.string :slug
      t.datetime :published_at

      t.timestamps
    end
  end
end
