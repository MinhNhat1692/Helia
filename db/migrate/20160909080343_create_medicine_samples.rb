class CreateMedicineSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :medicine_samples do |t|
      t.integer :type
      t.string :name
      t.integer :group
      t.string :company
      t.float :price
      t.float :weight
      t.text :remark
      t.integer :expire
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
