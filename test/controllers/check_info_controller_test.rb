require 'test_helper'

class CheckInfoControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get check_info_update_url
    assert_response :success
  end

  test "should get destroy" do
    get check_info_destroy_url
    assert_response :success
  end

  test "should get list" do
    get check_info_list_url
    assert_response :success
  end

  test "should get search" do
    get check_info_search_url
    assert_response :success
  end

end
