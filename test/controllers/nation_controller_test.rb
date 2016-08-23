require 'test_helper'

class NationControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get nation_list_url
    assert_response :success
  end

end
