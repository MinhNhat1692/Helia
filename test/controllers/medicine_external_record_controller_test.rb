require 'test_helper'

class MedicineExternalRecordControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get medicine_external_record_list_url
    assert_response :success
  end

  test "should get create" do
    get medicine_external_record_create_url
    assert_response :success
  end

  test "should get update" do
    get medicine_external_record_update_url
    assert_response :success
  end

  test "should get destroy" do
    get medicine_external_record_destroy_url
    assert_response :success
  end

  test "should get search" do
    get medicine_external_record_search_url
    assert_response :success
  end

  test "should get find" do
    get medicine_external_record_find_url
    assert_response :success
  end

end
