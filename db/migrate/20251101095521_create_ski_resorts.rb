class CreateSkiResorts < ActiveRecord::Migration[8.1]
  def change
    create_table :ski_resorts do |t|
      t.string :name, null: false
      t.string :booking_url, null: false
      t.timestamps
    end
  end
end
