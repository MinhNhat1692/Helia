class AddSupplierIdToMedicineBillIns < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_bill_ins, :supplier_id, :integer
  end
end
