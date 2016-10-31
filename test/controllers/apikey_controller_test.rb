require 'test_helper'

class ApikeyControllerTest < ActionDispatch::IntegrationTest
  test "should get getkey" do
    get apikey_getkey_url
    assert_response :success
  end

  test "should get changekey" do
    get apikey_changekey_url
    assert_response :success
  end

  test "should get addkey" do
    get apikey_addkey_url
    assert_response :success
  end

end
