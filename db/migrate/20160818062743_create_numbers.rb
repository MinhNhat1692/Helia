class CreateNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :numbers do |t|
      t.references :order_map, foreign_key: true
      t.references :room, foreign_key: true
      t.integer :number
      t.integer :status
      t.date :date

      t.timestamps
    end
  end
end
