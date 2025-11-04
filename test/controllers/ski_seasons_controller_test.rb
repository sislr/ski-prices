require "test_helper"

class SkiSeasonsControllerTest < ActionDispatch::IntegrationTest
  test "show returns http success" do
    get ski_season_path(ski_seasons(:st_moritz_2025_2026))
    assert_response :success
  end
end
