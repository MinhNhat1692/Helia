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

    def sum_amount_at_date date, station_id
      sql = "CALL stock_record_sum_in_date('#{date}', #{station_id})"
      result = MedicineStockRecord.connection.select_all sql
      statistic = []
      result.rows.each do |row|
        data = {}
        data[:noid] = row[1]
        data[:signid] = row[2]
        data[:sample_id] = row[3]
        data[:qty] = row[0]
        statistic << data
      end
      statistic
    end

    def sum_amount_between start_date, end_date, station_id
      sql = "CALL stock_record_sum_between('#{start_date}', '#{end_date}', #{station_id})"
      result = MedicineStockRecord.connection.select_all sql
      statistic = []
      result.rows.each do |row|
        data = {}
        data[:noid] = row[1]
        data[:signid] = row[2]
        data[:sample_id] = row[3]
        data[:qty] = row[0]
        statistic << data
      end
      statistic

    end

    def sum_amount_by_noid_and_signid
      statistic = []
      samples = MedicineStockRecord.pluck(:noid, :signid).uniq
      samples.each do |sample|
        h = {}
        records = MedicineStockRecord.where(noid: sample[0], signid: sample[1])
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
        h[:noid] = sample[0]
        h[:signid] = sample[1]
        h[:amount] = sum
        statistic << h
      end
      statistic
    end
  end
end
