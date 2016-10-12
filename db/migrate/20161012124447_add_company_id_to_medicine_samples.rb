class AddCompanyIdToMedicineSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_samples, :company_id, :integer
  end
end
