class MedicinePrescriptInternal < ApplicationRecord
  belongs_to :station
  after_update :update_int_record
  
  class << self
    def from_date n
      start_date = n.days.ago.beginning_of_day
      end_date = Time.now.end_of_day
      MedicinePrescriptInternal.where(created_at: start_date..end_date)
    end

    def in_range start,fin
      start_date = start.beginning_of_day
      end_date = fin.end_of_day
      MedicinePrescriptInternal.where(created_at: start_date..end_date)
    end
  end

  private
    def update_int_record
      records = MedicineInternalRecord.where(script_id: self.id)
      if records && self.code != self.code_was
        records.each do |record|
          record.update(script_code: self.code)
        end
      end
    end
end
