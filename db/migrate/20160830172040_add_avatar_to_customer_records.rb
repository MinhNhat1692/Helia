class AddAvatarToCustomerRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_records, :avatar, :string
  end
end
