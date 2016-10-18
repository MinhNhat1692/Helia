class CreateCLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :c_logs do |t|
      t.date :d_a
      t.text :c_c
      t.text :c_content

      t.timestamps
    end
  end
end
