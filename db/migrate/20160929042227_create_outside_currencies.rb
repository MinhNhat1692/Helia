class CreateOutsideCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :outside_currencies do |t|
      t.string :name
      t.text :remark
      t.integer :category
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
