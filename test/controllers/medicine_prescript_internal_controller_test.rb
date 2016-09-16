require 'test_helper'

class MedicinePrescriptInternalControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get medicine_prescript_internal_list_url
    assert_response :success
  end

  test "should get create" do
    get medicine_prescript_internal_create_url
    assert_response :success
  end

  test "should get update" do
    get medicine_prescript_internal_update_url
    assert_response :success
  end

  test "should get destroy" do
    get medicine_prescript_internal_destroy_url
    assert_response :success
  end

  test "should get search" do
    get medicine_prescript_internal_search_url
    assert_response :success
  end

  test "should get find" do
    get medicine_prescript_internal_find_url
    assert_response :success
  end

end
