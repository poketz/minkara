require "test_helper"

class ForumFavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get forum_favorites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get forum_favorites_destroy_url
    assert_response :success
  end
end
