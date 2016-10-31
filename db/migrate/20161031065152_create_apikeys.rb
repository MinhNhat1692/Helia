class CreateApikeys < ActiveRecord::Migration[5.0]
  def change
    create_table :apikeys do |t|
      t.references :user, foreign_key: true
      t.string :appid
      t.string :soapi
      t.string :mapi
      t.string :adminapi

      t.timestamps
    end
  end
end
