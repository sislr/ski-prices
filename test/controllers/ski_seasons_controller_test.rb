require "test_helper"

class SkiSeasonsControllerTest < ActionDispatch::IntegrationTest
  test "show returns http success" do
    get ski_season_path(ski_seasons(:st_moritz_2025_2026))
    assert_response :success
  end

  test "show returns https success with slug" do
    get "/ski_seasons/st-moritz-25"
    assert_response :success

    get "/ski_seasons/st-moritz-25?month=12"
    assert_response :success
  end

  test "show with month filter" do
    get ski_season_path(ski_seasons(:st_moritz_2025_2026), month: 12)
    assert_response :success
    assert_in_body "December"
  end

  test "show with date filter inside season" do
    get ski_season_path(ski_seasons(:st_moritz_2025_2026), date: Date.new(2025, 12, 12))
    assert_response :success
    assert_in_body "December"
  end

  test "show with date filter outside season" do
    get ski_season_path(ski_seasons(:st_moritz_2025_2026), date: Date.new(2025, 8, 12))
    assert_response :success
    assert_in_body "November"
  end

  test "show with invalid date filter" do
    get ski_season_path(ski_seasons(:st_moritz_2025_2026), date: "blub")
    assert_response :success
    assert_in_body "November"
  end
end
