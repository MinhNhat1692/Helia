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

    def sample_statistic station_id
      sql = "CALL stock_records_statistic(#{station_id})"
      result = MedicineStockRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        data = {}
        if row[0] != 0
          data[:id] = id
          data[:name] = row[2]
          data[:sam_id] = row[1]
          data[:qty] = row[0]
          statistic << data
          id += 1
        end
      end
      statistic
    end

    def statistic_detail med_name, sample_id, station_id
      sql = "CALL stock_records_detail_statistic('#{med_name}', #{sample_id}, #{station_id})"
      result = MedicineStockRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        data = {}
        if row[0] != 0
          data[:id] = id
          data[:noid] = row[1]
          data[:signid] = row[2]
          data[:amount] = row[0]
          statistic << data
          id += 1
        end
      end
      statistic

    end

    def sum_amount_at_date date, med_name, sample_id, no_id, sign_id, station_id
      sql = "CALL stock_record_sum_in_date('#{date}', '#{med_name}', #{sample_id}, '#{no_id}', '#{sign_id}',#{station_id})"
      result = MedicineStockRecord.connection.select_all sql
      statistic = []
      id = 1
      if result.rows.length == 1 && result.rows[0] == [nil, nil, nil, nil, nil]
        statistic = [{ id: 1, date: date.to_s, qty: 0 }]
      else
        result.rows.each do |row|
          data = {}
          data[:id] = id
          data[:date] = date.to_s
          data[:name] = row[4]
          data[:sam_id] = row[3]
          data[:n_id] = row[1]
          data[:s_id] = row[2]
          data[:qty] = row[0]
          statistic << data
          id += 1
        end
      end
      statistic
    end

    def sum_amount_between start_date, end_date, med_name, sample_id, no_id, sign_id, station_id
      sql = "CALL stock_record_sum_between('#{start_date}', '#{end_date}', '#{med_name}', #{sample_id}, '#{no_id}', '#{sign_id}', #{station_id})"
      result = MedicineStockRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        data = {}
        data[:id] = id
        data[:date] = row[5].to_s
        data[:n_id] = row[1]
        data[:s_id] = row[2]
        data[:sam_id] = row[3]
        data[:name] = row[4]
        data[:qty] = row[0]
        statistic << data
        id += 1
      end
      statistic
    end

    def statistic_by_sample_and_supplier start_date, end_date, sup_name, sup_id, sample, sample_id, station_id
      sql = "CALL stock_records_statistic_by_sample_and_supllier('#{start_date}', '#{end_date}', '#{sup_name}', #{sup_id}, '#{sample}', #{sample_id}, #{station_id})"
      result = MedicineStockRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        data = {}
        data[:id] = id
        data[:date] = row[1].to_s
        data[:sup_id] = row[2]
        data[:sample] = row[3]
        data[:amount] = row[0]
        statistic << data
        id += 1
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
