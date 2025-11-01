class CreateSkiPasses < ActiveRecord::Migration[8.1]
  def change
    create_table :ski_passes do |t|
      t.belongs_to :ski_season, null: false, foreign_key: true
      t.date :valid_on, null: false
      t.string :age_group, null: false
      t.timestamps
    end
  end
end
