require "test_helper"

class Fetchers::ZermattTest < ActiveSupport::TestCase
  test "fetch_prices! inserts price entries" do
    ski_resort = ski_resorts(:zermatt)
    current_season = ski_resort.current_ski_season
    season_days_2025_2026 = 162

    fetcher = Fetchers::Zermatt.new(ski_resort)
    fetcher.fetch_prices!

    assert_equal season_days_2025_2026, current_season.ski_passes.adult.count

    first_pass = current_season.ski_passes.adult.order(:valid_on).first
    last_pass = current_season.ski_passes.adult.order(:valid_on).last

    assert_equal 1, first_pass.price_entries.count
    assert first_pass.price_entries.first.price_in_chf > 40

    assert_equal 1, last_pass.price_entries.count
    assert last_pass.price_entries.first.price_in_chf > 40
  end
end
