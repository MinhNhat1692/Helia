require 'test_helper'

class StationControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get station_new_url
    assert_response :success
  end

  test "should get edit" do
    get station_edit_url
    assert_response :success
  end

  test "should get show" do
    get station_show_url
    assert_response :success
  end

  test "should get create" do
    get station_create_url
    assert_response :success
  end

end
