require 'test_helper'

class DoctorProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get doctor_profile_new_url
    assert_response :success
  end

  test "should get create" do
    get doctor_profile_create_url
    assert_response :success
  end

  test "should get show" do
    get doctor_profile_show_url
    assert_response :success
  end

end
