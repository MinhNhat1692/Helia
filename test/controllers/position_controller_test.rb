require 'test_helper'

class PositionControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get position_create_url
    assert_response :success
  end

  test "should get update" do
    get position_update_url
    assert_response :success
  end

  test "should get destroy" do
    get position_destroy_url
    assert_response :success
  end

end
