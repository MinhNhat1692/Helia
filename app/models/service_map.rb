class ServiceMap < ApplicationRecord
  belongs_to :station
  belongs_to :service
  belongs_to :room
end
