class EmployeeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.employee_mailer.record_activation.subject
  #
  def record_activation(user, station, employee)
    @user = user
    @station = station
    @employee = employee
    mail to: user.email, subject: "Account activation"
  end
end
