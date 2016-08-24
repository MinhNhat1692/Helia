require 'test_helper'

class RoomControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get room_create_url
    assert_response :success
  end

  test "should get update" do
    get room_update_url
    assert_response :success
  end

  test "should get destroy" do
    get room_destroy_url
    assert_response :success
  end

  test "should get list" do
    get room_list_url
    assert_response :success
  end

end
