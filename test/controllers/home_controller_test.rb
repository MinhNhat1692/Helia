require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get home_new_url
    assert_response :success
  end

end
