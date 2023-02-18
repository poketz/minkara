require "test_helper"

class SeachesControllerTest < ActionDispatch::IntegrationTest
  test "should get post_seach" do
    get seaches_post_seach_url
    assert_response :success
  end

  test "should get user_seach" do
    get seaches_user_seach_url
    assert_response :success
  end
end
