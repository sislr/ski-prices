class CreateSkiSeasons < ActiveRecord::Migration[8.1]
  def change
    create_table :ski_seasons do |t|
      t.belongs_to :ski_resort, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end
  end
end
