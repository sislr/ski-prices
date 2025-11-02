require "test_helper"

class Fetchers::StMoritzTest < ActiveSupport::TestCase
  test "fetch_prices! inserts price entries" do
    ski_resort = ski_resorts(:st_moritz)
    current_season = ski_resort.current_ski_season
    season_days_2025_2026 = 156

    fetcher = Fetchers::StMoritz.new(ski_resort)
    run_with_retries { fetcher.fetch_prices! }

    assert_equal season_days_2025_2026, current_season.ski_passes.adult.count

    first_pass = current_season.ski_passes.adult.order(:valid_on).first
    last_pass = current_season.ski_passes.adult.order(:valid_on).last

    assert_equal Date.new(2025, 11, 22), first_pass.valid_on
    assert_equal 1, first_pass.price_entries.count
    assert first_pass.price_entries.first.price_in_chf > 40

    assert_equal Date.new(2026, 4, 26), last_pass.valid_on
    assert_equal 1, last_pass.price_entries.count
    assert last_pass.price_entries.first.price_in_chf > 40
  end

  MAX_ATTEMPTS = 3
  def run_with_retries
    attempts = 0
    begin
      attempts += 1
      yield
    rescue => e
      retry if attempts < MAX_ATTEMPTS
      raise e
    end
  end
end
