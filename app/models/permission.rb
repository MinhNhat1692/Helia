class Permission < ApplicationRecord
  belongs_to :station
  belongs_to :employee

  validates :employee_id, presence: true
  validates :station_id, presence: true
  validates :table_id, presence: true
  validates_uniqueness_of :table_id, scope: [:employee_id, :station_id]
  validates :can_create, inclusion: { in: [true, false] }
  validates :can_read, inclusion: { in: [true, false] }
  validates :can_update, inclusion: { in: [true, false] }
  validates :can_delete, inclusion: { in: [true, false] }
  validate :employee_must_in_station

  def employee_must_in_station
    if self.employee.present? && self.employee.station_id != self.station_id
      errors.add(:employee_id, "not belongs to station")
    end
  end
end
