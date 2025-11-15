class AddMonth < ActiveRecord::Migration[8.1]
  def change
    add_column :ski_passes, :month, :integer,
               as: "cast(strftime('%m', valid_on) as integer)",
               stored: false
  end
end
