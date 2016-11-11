class MedicineStockRecord < ApplicationRecord
  belongs_to :station

  class << self
    def to_date_check date
      day_begin = MedicineStockRecord.first.created_at.beginning_of_day
      day_end = date.end_of_day
      MedicineStockRecord.where(created_at: day_begin..day_end)
    end

    def sum_amount_by_sample
      h = Hash.new
      sample_ids = MedicineStockRecord.pluck(:sample_id).uniq
      sample_ids.each do |sample|
        records = MedicineStockRecord.where(sample_id: sample)
        sum = 0
        records.each do |record|
          if record.typerecord == 1
            sum += record.amount
          elsif record.typerecord == 2
            sum -= record.amount
          else
            sum += 0
          end
        end
        h[sample] = sum
      end
      h
    end
  end
end
