class OrderMap < ApplicationRecord
  belongs_to :customer_record
  belongs_to :service
end
