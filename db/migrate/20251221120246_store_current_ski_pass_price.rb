class StoreCurrentSkiPassPrice < ActiveRecord::Migration[8.1]
  def change
    add_column :ski_passes, :current_price_in_chf, :integer

    SkiPass.reset_column_information
    SkiPass.find_each do |ski_pass|
      last_price = ski_pass.price_entries.ordered_by_date.last&.price_in_chf
      ski_pass.update!(current_price_in_chf: last_price) if last_price
    end
  end
end
