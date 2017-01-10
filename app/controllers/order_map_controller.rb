class OrderMapController < ApplicationController
  before_action :logged_in_user
  
  def update
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 2
			  @station = Station.find params[:id_station]
			  if params.has_key?(:id)
          @supplier = OrderMap.find(params[:id])
          if @supplier.station_id == @station.id
		        @customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		        if !@customer_id.nil?
					    @customer_id = @customer_id.id
  				  end
	  	      @service_id = Service.find_by(id: params[:service_id], sname: params[:sername], station_id: @station.id)
		        if !@service_id.nil?
				      @service_id = @service_id.id
  		      end
		        if @supplier.code == nil
							if @supplier.update(code: params[:code], remark: params[:remark], customer_record_id: @customer_id, cname: params[:cname], service_id: @service_id, sername: params[:sername], status: params[:status], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
								render json: @supplier
							else
								render json: @supplier.errors, status: :unprocessable_entity
							end
						else
							if @supplier.update(remark: params[:remark], customer_record_id: @customer_id, cname: params[:cname], service_id: @service_id, sername: params[:sername], status: params[:status], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
								render json: @supplier
							else
								render json: @supplier.errors, status: :unprocessable_entity
							end
						end
	  	    end
	      end
	    else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  if params.has_key?(:id)
          @supplier = OrderMap.find(params[:id])
          if @supplier.station_id == @station.id
		        @customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		        if !@customer_id.nil?
					    @customer_id = @customer_id.id
  				  end
	  	      @service_id = Service.find_by(id: params[:service_id], sname: params[:sername], station_id: @station.id)
		        if !@service_id.nil?
				      @service_id = @service_id.id
  		      end
	  	      if @supplier.update(remark: params[:remark], customer_record_id: @customer_id, cname: params[:cname], service_id: @service_id, sername: params[:sername], status: params[:status], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
  		  		  render json: @supplier
	  		  	else
		  		  	render json: @supplier.errors, status: :unprocessable_entity
  		  		end
	  	    end
	      end
	    else
        redirect_to root_path
      end
    end
  end

  def create
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 1
			  @station = Station.find params[:id_station]
		    @customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		    if !@customer_id.nil?
					@customer_id = @customer_id.id
				end
		    @service_id = Service.find_by(id: params[:service_id], sname: params[:sername], station_id: @station.id)
		    if !@service_id.nil?
					@service_id = @service_id.id
		    end
		    #if params[:status] != 'Tình trạng'
				#	@status = params[:status]
				#else
				#	@status = 2
		    #end
		    @supplier = OrderMap.new(code: params[:code], station_id: @station.id, remark: params[:remark], customer_record_id: @customer_id, cname: params[:cname], service_id: @service_id, sername: params[:sername], status: params[:status], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
				if @supplier.save
				  render json: @supplier
				else
					render json: @supplier.errors, status: :unprocessable_entity
				end
		  else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
		    @customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		    if !@customer_id.nil?
					@customer_id = @customer_id.id
				end
		    @service_id = Service.find_by(id: params[:service_id], sname: params[:sername], station_id: @station.id)
		    if !@service_id.nil?
					@service_id = @service_id.id
		    end
		    #if params[:status] != 'Tình trạng'
				#	@status = params[:status]
				#else
				#	@status = 2
		    #end
		    @supplier = OrderMap.new(station_id: @station.id, remark: params[:remark], customer_record_id: @customer_id, cname: params[:cname], service_id: @service_id, sername: params[:sername], status: params[:status], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
				if @supplier.save
				  render json: @supplier
				else
					render json: @supplier.errors, status: :unprocessable_entity
				end
		  else
        redirect_to root_path
      end
    end
  end

  def list
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 4
			  @station = Station.find params[:id_station]
			  @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
          @data[0] = OrderMap.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = OrderMap.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = OrderMap.where(station_id: @station.id)
          @data[1] = MedicineGroup.all
          @data[2] = MedicineType.all
        end
			  render json: @data
		  else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
          @data[0] = OrderMap.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = OrderMap.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = OrderMap.where(station_id: @station.id)
          @data[1] = MedicineGroup.all
          @data[2] = MedicineType.all
        end
			  render json: @data
		  else
        redirect_to root_path
      end
    end
  end

  def summary
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
			  @station = Station.find params[:id_station]
			  @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start_date = n.days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          end_date = Time.now.to_date + 1
          start = (2*n).days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          fin = (n.days.ago.to_date - 1).end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          @data[0] = OrderMap.statistic start_date, end_date, @station.id
          @data[1] = OrderMap.statistic start, fin, @station.id
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          n = (end_date.to_date - start_date).to_i
          start = (start_date - n).beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          fin = (start_date - 1).end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          @data[0] = OrderMap.statistic start_date, end_date, @station.id
          @data[1] = OrderMap.statistic start, fin, @station.id
          render json: @data
        else
          redirect_to root_path
        end
		  else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start_date = n.days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          end_date = Time.now.to_date + 1
          start = (2*n).days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          fin = (n.days.ago.to_date - 1).end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          @data[0] = OrderMap.statistic start_date, end_date, @station.id
          @data[1] = OrderMap.statistic start, fin, @station.id
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          n = (end_date.to_date - start_date).to_i
          start = (start_date - n).beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          fin = (start_date - 1).end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          @data[0] = OrderMap.statistic start_date, end_date, @station.id
          @data[1] = OrderMap.statistic start, fin, @station.id
          render json: @data
        else
          redirect_to root_path
        end
		  else
        head :no_content
      end
    end
  end

  def destroy
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 3
			  @station = Station.find params[:id_station]
			  if params.has_key?(:id)
			    @supplier = OrderMap.find(params[:id])
			    if @supplier.station_id == @station.id
				    @supplier.destroy
				    head :no_content
			    end
			  end
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  if params.has_key?(:id)
			    @supplier = OrderMap.find(params[:id])
			    if @supplier.station_id == @station.id
				    @supplier.destroy
				    head :no_content
			    end
			  end
		  else
			  redirect_to root_path
		  end
    end
  end
  
  def search
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 4
        @station = Station.find params[:id_station]
        if params.has_key?(:cname)
          @supplier = OrderMap.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).limit(5)
			    render json:@supplier
        elsif params.has_key?(:sername)
				  @supplier = OrderMap.where("sername LIKE ? and station_id = ?" , "%#{params[:sername]}%", @station.id).group(:sername).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = OrderMap.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(5)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:cname)
          @supplier = OrderMap.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).limit(5)
			    render json:@supplier
        elsif params.has_key?(:sername)
				  @supplier = OrderMap.where("sername LIKE ? and station_id = ?" , "%#{params[:sername]}%", @station.id).group(:sername).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = OrderMap.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(5)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
  end

  def find
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 4
        @station = Station.find params[:id_station]
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
        else
          start = OrderMap.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:cname)
          @supplier = OrderMap.where(created_at: start..fin).where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
        elsif params.has_key?(:sername)
				  @supplier = OrderMap.where(created_at: start..fin).where("sername LIKE ? and station_id = ?" , "%#{params[:sername]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = OrderMap.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:status)
				  @supplier = OrderMap.where(created_at: start..fin).where("status = ? and station_id = ?" , params[:status], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:tpayment)
				  @supplier = OrderMap.where(created_at: start..fin).where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:discount)
				  @supplier = OrderMap.where(created_at: start..fin).where("discount = ? and station_id = ?" , params[:discount], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:tpayout)
				  @supplier = OrderMap.where(created_at: start..fin).where("tpayout = ? and station_id = ?" , params[:tpayout], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:customer_id)
				  @supplier = OrderMap.where(created_at: start..fin).where("customer_record_id = ? and station_id = ?" , params[:customer_id], @station.id)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
        else
          start = OrderMap.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:cname)
          @supplier = OrderMap.where(created_at: start..fin).where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
        elsif params.has_key?(:sername)
				  @supplier = OrderMap.where(created_at: start..fin).where("sername LIKE ? and station_id = ?" , "%#{params[:sername]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = OrderMap.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:status)
				  @supplier = OrderMap.where(created_at: start..fin).where("status = ? and station_id = ?" , params[:status], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:tpayment)
				  @supplier = OrderMap.where(created_at: start..fin).where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:discount)
				  @supplier = OrderMap.where(created_at: start..fin).where("discount = ? and station_id = ?" , params[:discount], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:customer_id)
				  @supplier = OrderMap.where(created_at: start..fin).where("customer_record_id = ? and station_id = ?" , params[:customer_id], @station.id)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
  end

  def extra
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
			  @station = Station.find params[:id_station]
			  if params.has_key?(:order_map_id)
			    @ordermap = OrderMap.find_by(id: params[:order_map_id], station_id: @station.id)
			    @data = []
			    @data[0] = CustomerRecord.find_by(id: @ordermap.customer_record_id, station_id: @station.id)
			    @data[1] = CheckInfo.find_by(order_map_id: @ordermap.id, station_id: @station.id)
			    @data[2] = DoctorCheckInfo.find_by(order_map_id: @ordermap.id, station_id: @station.id)
			    render json: @data
			  end
		  else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  if params.has_key?(:order_map_id)
			    @ordermap = OrderMap.find_by(id: params[:order_map_id], station_id: @station.id)
			    @data = []
			    @data[0] = CustomerRecord.find_by(id: @ordermap.customer_record_id, station_id: @station.id)
			    @data[1] = CheckInfo.find_by(order_map_id: @ordermap.id, station_id: @station.id)
			    @data[2] = DoctorCheckInfo.find_by(order_map_id: @ordermap.id, station_id: @station.id)
			    render json: @data
			  end
		  else
        redirect_to root_path
      end
    end
	end

  def call
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
			  @station = Station.find params[:id_station]
			  if params.has_key?(:id)
          check_info = CheckInfo.find_by(order_map_id: params[:id], station_id: @station.id)
          if check_info && check_info.status != 3
            check_info.update(status: 2)
            render json: check_info
          else
            head :no_content
          end
			  end
		  else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  if params.has_key?(:id)
          check_info = CheckInfo.find_by(order_map_id: params[:id], station_id: @station.id)
          if check_info && check_info.status != 3
            check_info.update(status: 2)
            render json: check_info
          else
            head :no_content
          end
			  end
		  else
        redirect_to root_path
      end
    end
  end
  
  def finish
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
			  @station = Station.find params[:id_station]
			  if params.has_key?(:order_map_id)
			    @ordermap = OrderMap.find_by(id: params[:order_map_id], station_id: @station.id)
          if @ordermap
            case @ordermap.status
            when 1
              type = 4
            when 2
              type = 3
            else
              type = @ordermap.status
            end
            @ordermap.update(status: type)
            check_info = CheckInfo.find_by(order_map_id: @ordermap.id, station_id: @station.id)
            check_info.update(status: 3) if check_info
            render json: @ordermap
          else
            head :no_content
          end
			  end
		  else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  if params.has_key?(:order_map_id)
			    @ordermap = OrderMap.find_by(id: params[:order_map_id], station_id: @station.id)
          if @ordermap
            case @ordermap.status
            when 1
              type = 4
            when 2
              type = 3
            else
              type = @ordermap.status
            end
            @ordermap.update(status: type)
            check_info = CheckInfo.find_by(order_map_id: @ordermap.id, station_id: @station.id)
            check_info.update(status: 3) if check_info
            render json: @ordermap
          else
            head :no_content
          end
			  end
		  else
        redirect_to root_path
      end
    end
	end
end
