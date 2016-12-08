class MedicineInternalRecord < ApplicationRecord
  belongs_to :station

  class << self
    def from_date n
      start_date = n.days.ago.beginning_of_day
      end_date = Time.now.end_of_day
      MedicineInternalRecord.where(created_at: start_date..end_date)
    end

    def in_range start,fin
      start_date = start.beginning_of_day
      end_date = fin.end_of_day
      MedicineInternalRecord.where(created_at: start_date..end_date)
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
        statistic[:records_qty] << MedicineInternalRecord.where(created_at: date.beginning_of_day..date.end_of_day).count
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
        statistic[:records_qty] << MedicineInternalRecord.where(created_at: date.beginning_of_day..date.end_of_day).count
      end
      statistic
    end
    
    def count_by_day start_date, end_date, station_id
      sql = "CALL internal_record_count_by_day('#{start_date}', '#{end_date}', #{station_id})"
      result = MedicineInternalRecord.connection.select_all sql
      statistic = {
        date: Array.new,
        records_qty: Array.new
      }
      result.rows.each do |row|
        statistic[:date] << row[1].to_s
        statistic[:records_qty] << row[0]
      end
      statistic
    end

    def statistic_by_day start_date, end_date, station_id
      sql = "CALL internal_record_statistic('#{start_date}', '#{end_date}', #{station_id})"
      result = MedicineInternalRecord.connection.select_all sql
      statistic = []
      result.rows.each do |row|
        data = {}
        data[[row[1], row[2], row[3]]] = row[0]
        statistic << data
      end
      statistic
    end
    
    def statistic_records start_date, end_date, med_name, company_id, price, station_id
      sql = "CALL internal_record_detail_statistic('#{start_date}', '#{end_date}', '#{med_name}', #{company_id}, #{price}, #{station_id} )"
      result = MedicineInternalRecord.connection.select_all sql
      statistic = []
      result.rows.each do |row|
        data = {}
        data[row[1].to_s] = row[0]
        statistic << data
      end
      statistic
    end
  end
end
