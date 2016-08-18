class CreatePositionMappings < ActiveRecord::Migration[5.0]
  def change
    create_table :position_mappings do |t|
      t.references :employee, foreign_key: true
      t.references :position, foreign_key: true
      t.datetime :time_end

      t.timestamps
    end
  end
end
