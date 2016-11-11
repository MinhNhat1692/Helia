class MedicineSample < ApplicationRecord
  belongs_to :station
  after_update :update_bill_record, :update_med_price,
    :update_med_ext_record, :update_med_int_record,
    :update_stock_record

  private
    def update_bill_record
      bills = MedicineBillRecord.where(sample_id: self.id)
      if bills && self.name != self.name_was
        bills.each do |bill|
          bill.update(name: self.name)
        end
      end
    end

    def update_med_price
      prices = MedicinePrice.where(sample_id: self.id)
      if prices && self.name != self.name_was
        prices.each do |price|
          price.update(name: self.name)
        end
      end
    end

    def update_med_ext_record
      records = MedicineExternalRecord.where(sample_id: self.id)
      if records && self.name != self.name_was
        records.each do |record|
          record.update(name: self.name)
        end
      end
    end

    def update_med_int_record
      records = MedicineInternalRecord.where(sample_id: self.id)
      if records && self.name != self.name_was
        records.each do |record|
          record.update(name: self.name)
        end
      end
    end

    def update_stock_record
      records = MedicineStockRecord.where(sample_id: self.id)
      if records && self.name != self.name_was
        records.each do |record|
          record.update(name: self.name)
        end
      end
    end
end
