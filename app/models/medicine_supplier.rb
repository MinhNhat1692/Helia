class MedicineSupplier < ApplicationRecord
  belongs_to :station
  after_update :update_medicine_bill_in, :update_stock_record

  private
    def update_medicine_bill_in
      bills = MedicineBillIn.where(supplier_id: self.id)
      if bills && self.name != self.name_was
        bills.each do |bill|
          bill.update(supplier: self.name)
        end
      end
    end

    def update_stock_record
      records = MedicineStockRecord.where(supplier_id: self.id)
      if records && self.name != self.name_was
        records.each do |record|
          record.update(supplier: self.name)
        end
      end
    end
end
