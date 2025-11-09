class AddSlug < ActiveRecord::Migration[8.1]
  def change
    add_column :ski_seasons, :slug, :string
    add_index :ski_seasons, :slug, unique: true
  end
end
