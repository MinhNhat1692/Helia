class CreatePreOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :pre_orders do |t|
      t.references :station, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :time_arrived
      t.string :code

      t.timestamps
    end
  end
end
