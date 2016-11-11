class MedicineCompany < ApplicationRecord
  belongs_to :station
  after_update :update_med_sample, :update_med_bill_record, :update_external_record,
    :update_internal_record

  private
    def update_med_sample
      med_samples = MedicineSample.where(company_id: self.id)
      if med_samples && self.name != self.name_was
        med_samples.each do |sample|
          sample.update(company: self.name)
        end
      end
    end

    def update_med_bill_record
      med_records = MedicineBillRecord.where(company_id: self.id)
      if med_records && self.name != self.name_was
        med_records.each do |record|
          record.update(company: self.name)
        end
      end
    end

    def update_external_record
      ext_records = MedicineExternalRecord.where(company_id: self.id)
      if ext_records && self.name != self.name_was
        ext_records.each do |record|
          record.update(company: self.name)
        end
      end
    end

    def update_internal_record
      int_records = MedicineInternalRecord.where(company_id: self.id)
      if int_records && self.name != self.name_was
        int_records.each do |record|
          record.update(company: self.name)
        end
      end
    end
end
