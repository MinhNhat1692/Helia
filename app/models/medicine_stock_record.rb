class MedicineStockRecord < ApplicationRecord
  belongs_to :station

  class << self
    def from_date n
      start_date = n.days.ago.beginning_of_day
      end_date = Time.now.end_of_day
      MedicinePrescriptExternal.where(created_at: start_date..end_date)
    end

    def in_range start,fin
      start_date = start.beginning_of_day
      end_date = fin.end_of_day
      MedicinePrescriptExternal.where(created_at: start_date..end_date)
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
