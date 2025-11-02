class UniquenessIndex < ActiveRecord::Migration[8.1]
  def change
    add_index :ski_passes, [ :ski_season_id, :valid_on, :age_group ], unique: true,
              name: 'index_ski_passes_on_season_date_agegroup'
  end
end
