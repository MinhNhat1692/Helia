class AddIndexToApikeyKey < ActiveRecord::Migration[5.0]
  def change
    add_index :apikeys, :appid, unique: true
    add_index :apikeys, :soapi, unique: true
    add_index :apikeys, :mapi, unique: true
    add_index :apikeys, :adminapi, unique: true
  end
end
