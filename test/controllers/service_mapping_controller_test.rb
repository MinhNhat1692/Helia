require 'test_helper'

class ServiceMappingControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get service_mapping_create_url
    assert_response :success
  end

  test "should get update" do
    get service_mapping_update_url
    assert_response :success
  end

  test "should get destroy" do
    get service_mapping_destroy_url
    assert_response :success
  end

  test "should get list" do
    get service_mapping_list_url
    assert_response :success
  end

end
