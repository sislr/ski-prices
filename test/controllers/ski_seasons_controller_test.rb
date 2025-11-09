require "test_helper"

class SkiSeasonsControllerTest < ActionDispatch::IntegrationTest
  test "show returns http success" do
    get ski_season_path(ski_seasons(:st_moritz_2025_2026))
    assert_response :success
  end

  test "show returns https success with slug" do
    assert_routing "/ski_seasons/st-moritz-25", controller: "ski_seasons", action: "show", slug: "st-moritz-25"
    assert_routing "/st-moritz-25", controller: "ski_seasons", action: "show", slug: "st-moritz-25"
  end
end
