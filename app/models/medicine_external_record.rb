class MedicineExternalRecord < ApplicationRecord
  belongs_to :station
  
  class << self
    def from_date n
      start_date = n.days.ago.beginning_of_day
      end_date = Time.now.end_of_day
      MedicineExternalRecord.where(created_at: start_date..end_date)
    end

    def in_range start,fin
      start_date = start.beginning_of_day
      end_date = fin.end_of_day
      MedicineExternalRecord.where(created_at: start_date..end_date)
    end
  end
end
