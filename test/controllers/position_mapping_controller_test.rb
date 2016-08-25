require 'test_helper'

class PositionMappingControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get position_mapping_create_url
    assert_response :success
  end

  test "should get update" do
    get position_mapping_update_url
    assert_response :success
  end

  test "should get destroy" do
    get position_mapping_destroy_url
    assert_response :success
  end

  test "should get list" do
    get position_mapping_list_url
    assert_response :success
  end

end
