require 'test_helper'

class MedicineBillInControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get medicine_bill_in_list_url
    assert_response :success
  end

  test "should get create" do
    get medicine_bill_in_create_url
    assert_response :success
  end

  test "should get update" do
    get medicine_bill_in_update_url
    assert_response :success
  end

  test "should get destroy" do
    get medicine_bill_in_destroy_url
    assert_response :success
  end

  test "should get search" do
    get medicine_bill_in_search_url
    assert_response :success
  end

  test "should get find" do
    get medicine_bill_in_find_url
    assert_response :success
  end

end
