require 'test_helper'

class MedicinePrescriptExternalControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get medicine_prescript_external_list_url
    assert_response :success
  end

  test "should get create" do
    get medicine_prescript_external_create_url
    assert_response :success
  end

  test "should get update" do
    get medicine_prescript_external_update_url
    assert_response :success
  end

  test "should get destroy" do
    get medicine_prescript_external_destroy_url
    assert_response :success
  end

  test "should get search" do
    get medicine_prescript_external_search_url
    assert_response :success
  end

  test "should get find" do
    get medicine_prescript_external_find_url
    assert_response :success
  end

end
