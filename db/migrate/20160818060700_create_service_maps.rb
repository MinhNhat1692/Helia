class CreateServiceMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :service_maps do |t|
      t.references :service, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
