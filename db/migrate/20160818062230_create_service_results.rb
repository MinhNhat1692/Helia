class CreateServiceResults < ActiveRecord::Migration[5.0]
  def change
    create_table :service_results do |t|
      t.references :order_map, foreign_key: true
      t.references :user, foreign_key: true
      t.string :info
      t.string :result

      t.timestamps
    end
  end
end
