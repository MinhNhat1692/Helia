class MedicineInternalRecord < ApplicationRecord
  belongs_to :station
  after_update :update_stock_record

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
      sql = "CALL internal_record_statistic('#{start_date}', '#{end_date}', #{station_id})"
      result = MedicineInternalRecord.connection.select_all sql
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
      sql = "CALL internal_record_detail_statistic('#{start_date}', '#{end_date}', '#{med_name}', '#{company_id}', #{price}, #{station_id} )"
      result = MedicineInternalRecord.connection.select_all sql
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

    def statistic_by_sample start_date, end_date, station_id
      sql = "CALL internal_records_by_sample('#{start_date}', '#{end_date}', #{station_id})"
      result = MedicineInternalRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        data = {}
        data[:id] = id
        data[:date] = row[1].to_s
        data[:sample_id] = row[2]
        data[:name] = row[3]
        data[:t_sale] = row[0]
        statistic << data
        id += 1
      end
      statistic
    end

    def medicine_sale start_date, end_date, station_id
      sql = "CALL medicine_sale('#{start_date}', '#{end_date}', #{station_id})"
      result = MedicineInternalRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        data = {}
        data[:id] = id
        data[:date] = row[0].to_s
        data[:t_sale] = row[1] - row[2]
        statistic << data
        id += 1
      end
      statistic
    end
  end

  private
    def update_stock_record
      stock_record = MedicineStockRecord.find_by(internal_record_id: self.id)
      if stock_record && self.status != self.status_was
        case self.status
        when 1
          typerecord = 2
        else
          typerecord = 3
        end
        stock_record.update(typerecord: typerecord)
      end
    end
end
