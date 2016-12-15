class OrderMap < ApplicationRecord
  after_create :create_check_info, :create_doctor_check_info

  belongs_to :customer_record
  belongs_to :service
  has_one :check_info, dependent: :destroy
  has_one :doctor_check_info, dependent: :destroy

  class << self
    def statistic start_date, end_date, station_id
      sql = "CALL order_map_stat('#{start_date}', '#{end_date}', #{station_id})"
      result = OrderMap.connection.select_all sql
      stat = []
      id = 1
      result.rows.each do |row|
        data = {}
        data[:id] = id
        data[:date] = row[2].to_s
        data[:s_id] = row[3]
        data[:s_name] = row[4]
        data[:income] = row[0]
        data[:count] = row[1]
        stat << data
        id += 1
      end
      stat
    end

    def total_sale start_date, end_date, station_id
      sql = "CALL services_sale('#{start_date}', '#{end_date}', #{station_id})"
      result = OrderMap.connection.select_all sql
      stat = []
      id = 1
      result.rows.each do |row|
        data = {}
        data[:id] = id
        data[:date] = row[0].to_s
        data[:t_sale] = row[1]
        stat << data
        id += 1
      end
      stat
    end
  end

  private
    def create_check_info
      station = Station.find_by(id: self.station_id)
      if station
		    @checkinfo = CheckInfo.new(status: 1, order_map_id: self.id, 
                                   c_id: self.customer_record.id, 
                                   c_name: self.customer_record.cname, station_id: station.id)
        if @checkinfo.valid?
          @checkinfo.save
        end
      end
    end
    
    def create_doctor_check_info
      station = Station.find_by(id: self.station_id)
      if station
		    @checkinfo = DoctorCheckInfo.new(order_map_id: self.id, 
                                   c_id: self.customer_record.id, 
                                   c_name: self.customer_record.cname, station_id: station.id)
        if @checkinfo.valid?
          @checkinfo.save
        end
      end
    end
end
