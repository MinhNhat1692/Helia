require 'test_helper'

class MedicineCompanyControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get medicine_company_list_url
    assert_response :success
  end

  test "should get create" do
    get medicine_company_create_url
    assert_response :success
  end

  test "should get update" do
    get medicine_company_update_url
    assert_response :success
  end

  test "should get search" do
    get medicine_company_search_url
    assert_response :success
  end

  test "should get find" do
    get medicine_company_find_url
    assert_response :success
  end

  test "should get destroy" do
    get medicine_company_destroy_url
    assert_response :success
  end

end
