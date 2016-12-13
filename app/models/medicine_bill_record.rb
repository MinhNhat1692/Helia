class MedicineBillRecord < ApplicationRecord
  belongs_to :station
  
  class << self
    def from_date n
      start_date = n.days.ago.beginning_of_day
      end_date = Time.now.end_of_day
      MedicineBillRecord.where(created_at: start_date..end_date)
    end

    def in_range start,fin
      start_date = start.beginning_of_day
      end_date = fin.end_of_day
      MedicineBillRecord.where(created_at: start_date..end_date)
    end

    def sum_payment start_date, end_date, s_name, supplier_id, station_id
      sql = "CALL bill_record_sum_up('#{start_date}', '#{end_date}', '#{s_name}', #{supplier_id}, #{station_id})"
      result = MedicineBillRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        h = {}
        h[:id] = id
        h[:sam_id] = row[2]
        h[:sample] = MedicineSample.find_by(id: row[2]).try(:name)
        h[:t_qty] = row[0]
        h[:t_payment] = row[1]
        statistic << h
        id += 1
      end
      statistic
    end

    def origin_price start_date, end_date, station_id
      sql = "CALL bill_record_origin_price('#{start_date}', '#{end_date}', #{station_id})"
      result = MedicineBillRecord.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        h = {}
        h[:id] = id
        h[:date] = row[1].to_s
        h[:sam_id] = row[2]
        h[:name] = row[3]
        h[:tprice] = row[0]
        statistic << h
        id += 1
      end
      statistic
    end
  end
end
