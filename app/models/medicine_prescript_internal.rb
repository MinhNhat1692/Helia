class MedicinePrescriptInternal < ApplicationRecord
  belongs_to :station
  after_update :update_int_record

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
