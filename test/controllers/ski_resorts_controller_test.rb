require "test_helper"

class SkiResortsControllerTest < ActionDispatch::IntegrationTest
  test "index returns http success" do
    get ski_resorts_path
    assert_response :success
  end

  test "index renders active seasons in the main grid" do
    travel_to Date.new(2026, 1, 15) do
      get ski_resorts_path

      assert_select "section > ul > li", count: SkiSeason.count
      assert_select "h2", text: "Past seasons", count: 0
    end
  end

  test "index renders past seasons in their own section" do
    travel_to Date.new(2026, 6, 1) do
      get ski_resorts_path

      assert_select "h2", text: "Past seasons"
      # Active grid is empty; past grid contains every season.
      assert_select "section > ul > li", count: 0
      assert_select "div.border-t ul > li", count: SkiSeason.count
    end
  end

  test "index hides past seasons section when there are no past seasons" do
    travel_to Date.new(2026, 1, 15) do
      get ski_resorts_path
      assert_select "h2", text: "Past seasons", count: 0
      assert_select "div.border-t", count: 0
    end
  end
end
