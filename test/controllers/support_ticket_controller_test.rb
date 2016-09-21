require 'test_helper'

class SupportTicketControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get support_ticket_add_url
    assert_response :success
  end

  test "should get close" do
    get support_ticket_close_url
    assert_response :success
  end

  test "should get open" do
    get support_ticket_open_url
    assert_response :success
  end

  test "should get remove" do
    get support_ticket_remove_url
    assert_response :success
  end

end
