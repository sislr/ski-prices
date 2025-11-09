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

  test "average_price_in_chf_per_month" do
    season = ski_seasons(:st_moritz_2025_2026)

    PriceEntry.create!(
      ski_pass: SkiPass.create!(ski_season: season, age_group: "adult",
                                valid_on: Date.new(2025, 11, 25)),
      price_in_chf: 100
    )
    PriceEntry.create!(
      ski_pass: SkiPass.create!(ski_season: season, age_group: "adult",
                                valid_on: Date.new(2025, 11, 26)),
      price_in_chf: 200
    )
    PriceEntry.create!(
      ski_pass: SkiPass.create!(ski_season: season, age_group: "adult",
                                valid_on: Date.new(2025, 12, 15)),
      price_in_chf: 115
    )
    PriceEntry.create!(
      ski_pass: SkiPass.create!(ski_season: season, age_group: "adult",
                                valid_on: Date.new(2026, 1, 1)),
      price_in_chf: 100
    )

    expected = {
      "November" => 150,
      "December" => 100,
      "January" => 100
    }
    assert_equal expected, season.average_price_in_chf_per_month
  end
end
