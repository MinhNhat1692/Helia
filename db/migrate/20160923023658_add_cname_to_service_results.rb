class AddCnameToServiceResults < ActiveRecord::Migration[5.0]
  def change
    add_column :service_results, :cname, :string
  end
end
