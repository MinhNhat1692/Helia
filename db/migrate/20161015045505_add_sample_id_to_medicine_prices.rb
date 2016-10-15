class AddSampleIdToMedicinePrices < ActiveRecord::Migration[5.0]
  def change
    add_column :medicine_prices, :sample_id, :integer
  end
end
