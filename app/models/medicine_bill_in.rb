class MedicineBillIn < ApplicationRecord
  belongs_to :station
  
  class << self
    def from_date n
      start_date = n.days.ago.beginning_of_day
      end_date = Time.now.end_of_day
      MedicineBillIn.where(created_at: start_date..end_date)
    end

    def in_range start,fin
      start_date = start.beginning_of_day
      end_date = fin.end_of_day
      MedicineBillIn.where(created_at: start_date..end_date)
    end

    def sum_payout start_date, end_date, station_id
      sql = "CALL bill_in_sum_up('#{start_date}', '#{end_date}', #{station_id})"
      result = MedicineBillIn.connection.select_all sql
      statistic = []
      id = 1
      result.rows.each do |row|
        h = {}
        h[:id] = id
        h[:tpayout] = row[0]
        h[:supp_id] = row[1]
        h[:supplier] = row[2]
        statistic << h
        id += 1
      end
      statistic
    end
  end
end
