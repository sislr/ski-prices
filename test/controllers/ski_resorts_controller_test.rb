require "test_helper"

class SkiResortsControllerTest < ActionDispatch::IntegrationTest
  test "index returns http success" do
    get ski_resorts_path
    assert_response :success
  end

  test "index assigns active seasons grouped with their resort" do
    travel_to Date.new(2026, 1, 15) do
      get ski_resorts_path

      pairs = assigns(:active_seasons_by_resort)
      seasons = pairs.map(&:last)
      assert_includes seasons, ski_seasons(:st_moritz_2025_2026)
      assert_includes seasons, ski_seasons(:zermatt_2025_2026)
      assert_includes seasons, ski_seasons(:arosa_lenzerheide_2025_2026)
      assert_empty assigns(:past_seasons_by_resort)

      pairs.each { |resort, season| assert_equal resort, season.ski_resort }
    end
  end

  test "index assigns past seasons once all are over" do
    travel_to Date.new(2026, 6, 1) do
      get ski_resorts_path

      past_seasons = assigns(:past_seasons_by_resort).map(&:last)
      assert_includes past_seasons, ski_seasons(:st_moritz_2025_2026)
      assert_includes past_seasons, ski_seasons(:zermatt_2025_2026)
      assert_includes past_seasons, ski_seasons(:arosa_lenzerheide_2025_2026)
      assert_empty assigns(:active_seasons_by_resort)
    end
  end

  test "index renders past seasons section heading when past seasons exist" do
    travel_to Date.new(2026, 6, 1) do
      get ski_resorts_path
      assert_select "h2", text: "Past seasons"
    end
  end

  test "index hides past seasons section when none exist" do
    travel_to Date.new(2026, 1, 15) do
      get ski_resorts_path
      assert_select "h2", text: "Past seasons", count: 0
    end
  end
end
