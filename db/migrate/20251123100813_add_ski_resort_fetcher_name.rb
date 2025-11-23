class AddSkiResortFetcherName < ActiveRecord::Migration[8.1]
  def change
    add_column :ski_resorts, :fetcher_class_name, :string
    add_index :ski_resorts, :fetcher_class_name, unique: true
  end
end
