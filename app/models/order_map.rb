class OrderMap < ApplicationRecord
  belongs_to :customer_record
  belongs_to :service
  has_one :check_info, dependent: :destroy
  has_one :doctor_check_info, dependent: :destroy
end
