require 'test_helper'

class CustomerRecordControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get customer_record_create_url
    assert_response :success
  end

  test "should get update" do
    get customer_record_update_url
    assert_response :success
  end

  test "should get destroy" do
    get customer_record_destroy_url
    assert_response :success
  end

  test "should get list" do
    get customer_record_list_url
    assert_response :success
  end

end
