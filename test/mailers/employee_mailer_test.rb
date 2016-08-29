require 'test_helper'

class EmployeeMailerTest < ActionMailer::TestCase
  test "record_activation" do
    mail = EmployeeMailer.record_activation
    assert_equal "Record activation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
