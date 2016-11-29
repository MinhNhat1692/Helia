class OrderMap < ApplicationRecord
  after_create :create_check_info, :create_doctor_check_info

  belongs_to :customer_record
  belongs_to :service
  has_one :check_info, dependent: :destroy
  has_one :doctor_check_info, dependent: :destroy

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
