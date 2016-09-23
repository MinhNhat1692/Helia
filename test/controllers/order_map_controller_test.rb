require 'test_helper'

class OrderMapControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get order_map_edit_url
    assert_response :success
  end

  test "should get create" do
    get order_map_create_url
    assert_response :success
  end

  test "should get list" do
    get order_map_list_url
    assert_response :success
  end

  test "should get destroy" do
    get order_map_destroy_url
    assert_response :success
  end

  test "should get search" do
    get order_map_search_url
    assert_response :success
  end

  test "should get find" do
    get order_map_find_url
    assert_response :success
  end

end
