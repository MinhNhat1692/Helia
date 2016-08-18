class ServiceResult < ApplicationRecord
  belongs_to :order_map
  belongs_to :user
end
