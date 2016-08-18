class CreatePositions < ActiveRecord::Migration[5.0]
  def change
    create_table :positions do |t|
      t.references :station, foreign_key: true
      t.references :room, foreign_key: true
      t.string :pname
      t.string :lang
      t.string :description
      t.string :file

      t.timestamps
    end
  end
end
