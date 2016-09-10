require 'test_helper'

class MedicineSupplierControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get medicine_supplier_list_url
    assert_response :success
  end

  test "should get create" do
    get medicine_supplier_create_url
    assert_response :success
  end

  test "should get update" do
    get medicine_supplier_update_url
    assert_response :success
  end

  test "should get destroy" do
    get medicine_supplier_destroy_url
    assert_response :success
  end

end
