require 'test_helper'

class SupportCommentControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get support_comment_add_url
    assert_response :success
  end

  test "should get remove" do
    get support_comment_remove_url
    assert_response :success
  end

end
