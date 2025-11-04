require "test_helper"

class SkiResortsControllerTest < ActionDispatch::IntegrationTest
  test "index returns http success" do
    get ski_resorts_path
    assert_response :success
  end
end
