class AddNoidToMedicineSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_samples, :noid, :string
  end
end
