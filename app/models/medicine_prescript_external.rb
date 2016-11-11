class MedicinePrescriptExternal < ApplicationRecord
  belongs_to :station
  after_update :update_ext_record

  private
    def update_ext_record
      records = MedicineExternalRecord.where(script_id: self.id)
      if records && self.code != self.code_was
        records.each do |record|
          record.update(script_code: self.code)
        end
      end
    end
end
