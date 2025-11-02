require "test_helper"

class SkiSeasonTest < ActiveSupport::TestCase
  test ".active" do
    season = ski_seasons(:st_moritz_2025_2026)
    assert_equal Date.new(2025, 11, 22), season.start_date
    assert_equal Date.new(2026, 4, 26), season.end_date

    travel_to Date.new(2025, 1, 1) do
      assert_not_includes SkiSeason.active, season
    end

    travel_to Date.new(2025, 9, 22) do
      assert_includes SkiSeason.active, season
    end

    travel_to Date.new(2026, 4, 1) do
      assert_includes SkiSeason.active, season
    end

    travel_to Date.new(2026, 4, 26) do
      assert_includes SkiSeason.active, season
    end

    travel_to Date.new(2026, 5, 1) do
      assert_not_includes SkiSeason.active, season
    end
  end
end
