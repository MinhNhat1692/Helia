class OrderMapController < ApplicationController
  before_action :logged_in_user, only: [:update, :create, :list, :destroy, :search, :find, :extra]
  
  def update
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 2
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
	  	      if @supplier.update(remark: params[:remark], customer_record_id: @customer_id, cname: params[:cname], service_id: @service_id, sername: params[:sername], status: params[:status], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
  		  		  render json: @supplier
	  		  	else
		  		  	render json: @supplier.errors, status: :unprocessable_entity
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
      if current_user.check_permission params[:id_station], params[:table_id], 1
			  @station = Station.find params[:id_station]
		    @customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		    if !@customer_id.nil?
					@customer_id = @customer_id.id
				end
		    @service_id = Service.find_by(id: params[:service_id], sname: params[:sername], station_id: @station.id)
		    if !@service_id.nil?
					@service_id = @service_id.id
		    end
		    if params[:status] != 'Tình trạng'
					@status = params[:status]
				else
					@status = 2
		    end
		    @supplier = OrderMap.new(station_id: @station.id, remark: params[:remark], customer_record_id: @customer_id, cname: params[:cname], service_id: @service_id, sername: params[:sername], status: @status, tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
				if @supplier.save
				#	@checkinfo = CheckInfo.new(status: 1, order_map_id: @supplier.id, c_id: @customer_id, c_name: params[:cname], station_id: @station.id)
				#	@checkinfo.save
				#	@doctorcheckinfo = DoctorCheckInfo.new(order_map_id: @supplier.id,c_id: @customer_id, c_name: params[:cname], station_id: @station.id)
				#	@doctorcheckinfo.save
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
		    if params[:status] != 'Tình trạng'
					@status = params[:status]
				else
					@status = 2
		    end
		    @supplier = OrderMap.new(station_id: @station.id, remark: params[:remark], customer_record_id: @customer_id, cname: params[:cname], service_id: @service_id, sername: params[:sername], status: @status, tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
				if @supplier.save
					@checkinfo = CheckInfo.new(status: 1, order_map_id: @supplier.id, c_id: @customer_id, c_name: params[:cname], station_id: @station.id)
					@checkinfo.save
					@doctorcheckinfo = DoctorCheckInfo.new(order_map_id: @supplier.id,c_id: @customer_id, c_name: params[:cname], station_id: @station.id)
					@doctorcheckinfo.save
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
      if current_user.check_permission params[:id_station], params[:table_id], 4
			  @station = Station.find params[:id_station]
			  @data = []
			  @data[0] = OrderMap.where(station_id: @station.id).order(updated_at: :desc).limit(200)
			  @data[1] = MedicineGroup.all
			  @data[2] = MedicineType.all
			  render json: @data
		  else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = OrderMap.where(station_id: @station.id).order(updated_at: :desc).limit(200)
			  @data[1] = MedicineGroup.all
			  @data[2] = MedicineType.all
			  render json: @data
		  else
        redirect_to root_path
      end
    end
  end

  def destroy
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 3
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
      if current_user.check_permission params[:id_station], params[:table_id], 4
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
      if current_user.check_permission params[:id_station], params[:table_id], 4
        @station = Station.find params[:id_station]
        if params.has_key?(:cname)
          @supplier = OrderMap.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
        elsif params.has_key?(:sername)
				  @supplier = OrderMap.where("sername LIKE ? and station_id = ?" , "%#{params[:sername]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = OrderMap.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:status)
				  @supplier = OrderMap.where("status = ? and station_id = ?" , params[:status], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:tpayment)
				  @supplier = OrderMap.where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:discount)
				  @supplier = OrderMap.where("discount = ? and station_id = ?" , params[:discount], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:tpayout)
				  @supplier = OrderMap.where("tpayout = ? and station_id = ?" , params[:tpayout], @station.id)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:cname)
          @supplier = OrderMap.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
        elsif params.has_key?(:sername)
				  @supplier = OrderMap.where("sername LIKE ? and station_id = ?" , "%#{params[:sername]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = OrderMap.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:status)
				  @supplier = OrderMap.where("status = ? and station_id = ?" , params[:status], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:tpayment)
				  @supplier = OrderMap.where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:discount)
				  @supplier = OrderMap.where("discount = ? and station_id = ?" , params[:discount], @station.id).order(updated_at: :desc).limit(1000)
			    render json:@supplier
			  elsif params.has_key?(:tpayout)
				  @supplier = OrderMap.where("tpayout = ? and station_id = ?" , params[:tpayout], @station.id)
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
end
