class CreateOrderMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :order_maps do |t|
      t.references :customer_record, foreign_key: true
      t.references :service, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
