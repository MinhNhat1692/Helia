class MedicineExternalRecord < ApplicationRecord
  belongs_to :station

  class << self
    def from_date n
      start_date = n.days.ago.beginning_of_day
      end_date = Time.now.end_of_day
      MedicineExternalRecord.where(created_at: start_date..end_date)
    end

    def in_range start, fin
      start_date = start.beginning_of_day
      end_date = fin.end_of_day
      MedicineExternalRecord.where(created_at: start_date..end_date)
    end

    def count_from_date n
      start_date = n.days.ago.to_date
      end_date = Time.now.to_date
      statistic = {
        date: Array.new,
        records_qty: Array.new
      }
      (start_date..end_date).each do |date|
        statistic[:date] << date.to_s
        statistic[:records_qty] << MedicineExternalRecord.where(created_at: date.beginning_of_day..date.end_of_day).count
      end
      statistic
    end

    def count_in_range start, fin
      statistic = {
        date: Array.new,
        records_qty: Array.new
      }
      (start..fin).each do |date|
        statistic[:date] << date.to_s
        statistic[:records_qty] << MedicineExternalRecord.where(created_at: date.beginning_of_day..date.end_of_day).count
      end
      statistic
    end

    def count_by_day start_date, end_date, station_id
      sql = "CALL external_record_count_by_day('#{start_date}', '#{end_date}', #{station_id})"
      result = MedicineExternalRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        h = {}
        h[:id] = id
        h[:d] = row[2].to_s
        h[:r] = row[0]
        h[:s] = row[1]
        statistic << h
        id += 1
      end
      statistic
    end
    
    def statistic_by_day start_date, end_date, station_id
      sql = "CALL external_record_statistic('#{start_date}', '#{end_date}', #{station_id})"
      result = MedicineExternalRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        data = {}
        data[:id] = id
        data[:name] = row[1]
        data[:company] = row[2]
        data[:price] = row[3]
        data[:amount] = row[0]
        statistic << data
        id += 1
      end
      statistic
    end

    def statistic_records start_date, end_date, med_name, company_id, price, station_id
      sql = "CALL external_record_detail_statistic('#{start_date}', '#{end_date}', '#{med_name}', '#{company_id}', #{price}, #{station_id} )"
      result = MedicineExternalRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        data = {}
        data[:id] = id
        data[:date] = row[1].to_s
        data[:amount] = row[0]
        statistic << data
        id += 1
      end
      statistic
    end
  end
end
