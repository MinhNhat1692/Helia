require 'test_helper'

class MedicinePriceControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get medicine_price_list_url
    assert_response :success
  end

  test "should get create" do
    get medicine_price_create_url
    assert_response :success
  end

  test "should get update" do
    get medicine_price_update_url
    assert_response :success
  end

  test "should get destroy" do
    get medicine_price_destroy_url
    assert_response :success
  end

  test "should get search" do
    get medicine_price_search_url
    assert_response :success
  end

  test "should get find" do
    get medicine_price_find_url
    assert_response :success
  end

end
