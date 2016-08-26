require 'test_helper'

class ServiceControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get service_create_url
    assert_response :success
  end

  test "should get update" do
    get service_update_url
    assert_response :success
  end

  test "should get destroy" do
    get service_destroy_url
    assert_response :success
  end

  test "should get list" do
    get service_list_url
    assert_response :success
  end

end
