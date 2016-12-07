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
      sql = "SELECT count(*) as qty, date(created_at) as date
             FROM medicine_external_records
             WHERE station_id = #{station_id} AND created_at BETWEEN '#{start_date}' AND '#{end_date}'
             GROUP BY date(created_at)"
      result = MedicineExternalRecord.connection.select_all sql
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
      MedicineExternalRecord.where(station_id: station_id, 
        created_at: start_date..end_date).group([:name, :company_id, :price]).sum(:amount)
    end

    def statistic_records start_date, end_date, med_name, company_id, price
      MedicineExternalRecord.where(created_at: start_date.beginning_of_day..end_date.end_of_day,
        price: price, name: med_name, company_id: company_id).group("date(created_at)").sum(:amount)
    end
  end
end
