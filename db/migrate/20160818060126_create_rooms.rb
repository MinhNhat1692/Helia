class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.references :station, foreign_key: true
      t.string :lang
      t.string :name
      t.string :map

      t.timestamps
    end
  end
end
