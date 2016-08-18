class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.references :station, foreign_key: true
      t.string :sname
      t.string :lang
      t.float :price
      t.string :currency
      t.string :description
      t.string :file

      t.timestamps
    end
  end
end
