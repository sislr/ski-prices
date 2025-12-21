require "test_helper"

class SkiPassTest < ActiveSupport::TestCase
  test "uniqueness per age group and date within a ski season" do
    ski_season = ski_seasons(:st_moritz_2025_2026)

    ski_pass1 = SkiPass.create!(
      ski_season: ski_season,
      valid_on: Date.new(2025, 12, 20),
      age_group: "adult"
    )
    ski_pass2 = SkiPass.new(
      ski_season: ski_season,
      valid_on: Date.new(2025, 12, 20),
      age_group: "adult"
    )
    assert_not ski_pass2.valid?

    ski_pass3 = SkiPass.new(
      ski_season: ski_season,
      valid_on: Date.new(2025, 12, 20),
      age_group: "child"
    )
    assert ski_pass3.valid?

    ski_pass4 = SkiPass.new(
      ski_season: ski_season,
      valid_on: Date.new(2025, 12, 21),
      age_group: "adult"
    )
    assert ski_pass4.valid?
  end

  test "valid_on date must be within ski season dates" do
    ski_season = ski_seasons(:st_moritz_2025_2026)

    ski_pass = SkiPass.new(
      ski_season: ski_season,
      valid_on: Date.new(2025, 11, 1),
      age_group: "adult"
    )
    assert_not ski_pass.valid?

    ski_pass.valid_on = Date.new(2026, 05, 01)
    assert_not ski_pass.valid?
  end
end
