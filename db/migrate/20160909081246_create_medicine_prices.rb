class CreateMedicinePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_prices do |t|
      t.references :station, foreign_key: true
      t.string :name
      t.integer :minam
      t.float :price
      t.text :remark

      t.timestamps
    end
  end
end
