class PositionMapping < ApplicationRecord
  belongs_to :station
  belongs_to :employee
  belongs_to :position
end
