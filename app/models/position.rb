class Position < ApplicationRecord
  belongs_to :station
  belongs_to :room
end
