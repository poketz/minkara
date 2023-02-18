require "test_helper"

class ForumsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forums_index_url
    assert_response :success
  end

  test "should get create" do
    get forums_create_url
    assert_response :success
  end

  test "should get show" do
    get forums_show_url
    assert_response :success
  end
end
