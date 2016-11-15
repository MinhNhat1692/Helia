class Permission < ApplicationRecord
  belongs_to :station
  belongs_to :user
  
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: [:station_id, :table_id]
  validates :station_id, presence: true
  validates :c_permit, inclusion: { in: [true, false] }
  validates :u_permit, inclusion: { in: [true, false] }
  validates :r_permit, inclusion: { in: [true, false] }
  validates :d_permit, inclusion: { in: [true, false] }
  validates :table_id, presence: true

  default_scope -> { order(station_id: :asc).order(user_id: :asc) }

  def belongs_to_station station
    self.station == station
  end
end
