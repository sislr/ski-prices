class AddYearMonthVirtualColumnToSkiPasses < ActiveRecord::Migration[8.1]
  def change
    add_column :ski_passes, :valid_on_year_month, :virtual, type: :string,
               as: "strftime('%Y-%m', valid_on)", stored: false
    rename_column :ski_passes, :month, :valid_on_month
  end
end
