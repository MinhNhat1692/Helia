require 'test_helper'

class RoomManagerControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get room_manager_list_url
    assert_response :success
  end

  test "should get detail" do
    get room_manager_detail_url
    assert_response :success
  end

end
