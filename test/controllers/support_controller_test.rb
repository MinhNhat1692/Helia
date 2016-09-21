require 'test_helper'

class SupportControllerTest < ActionDispatch::IntegrationTest
  test "should get listticket" do
    get support_listticket_url
    assert_response :success
  end

  test "should get ticketinfo" do
    get support_ticketinfo_url
    assert_response :success
  end

  test "should get addticket" do
    get support_addticket_url
    assert_response :success
  end

  test "should get deleteticket" do
    get support_deleteticket_url
    assert_response :success
  end

  test "should get closeticket" do
    get support_closeticket_url
    assert_response :success
  end

  test "should get addcomment" do
    get support_addcomment_url
    assert_response :success
  end

  test "should get deletecomment" do
    get support_deletecomment_url
    assert_response :success
  end

end
