class CreatePriceEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :price_entries do |t|
      t.belongs_to :ski_pass, null: false, foreign_key: true
      t.integer :price_in_chf, null: false
      t.timestamps
    end
  end
end
