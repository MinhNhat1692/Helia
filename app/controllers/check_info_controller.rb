class CheckInfoController < ApplicationController
  before_action :logged_in_user 
  
  def update
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 2
			  @station = Station.find params[:id_station]
			  if params.has_key?(:id)
          @supplier = CheckInfo.find(params[:id])
          if @supplier.station_id == @station.id
            @customer_id = CustomerRecord.find_by(id: params[:c_id], cname: params[:c_name], station_id: @station.id)
		        if !@customer_id.nil?
				      @customer_id = @customer_id.id
  		      end
            @employee_id = Employee.find_by(id: params[:e_id], ename: params[:ename], station_id: @station.id)
		        if !@employee_id.nil?
				      @employee_id = @employee_id.id
  		      end
		        if @supplier.update(status: params[:status], c_id: @customer_id, c_name: params[:c_name], ename: params[:ename], e_id: @employee_id, daystart: params[:daystart], dayend: params[:dayend], kluan: params[:kluan], cdoan: params[:cdoan], hdieutri: params[:hdieutri])
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
          @supplier = CheckInfo.find(params[:id])
          if @supplier.station_id == @station.id
            @customer_id = CustomerRecord.find_by(id: params[:c_id], cname: params[:c_name], station_id: @station.id)
		        if !@customer_id.nil?
				      @customer_id = @customer_id.id
  		      end
            @employee_id = Employee.find_by(id: params[:e_id], ename: params[:ename], station_id: @station.id)
		        if !@employee_id.nil?
				      @employee_id = @employee_id.id
  		      end
		        if @supplier.update(status: params[:status], c_id: @customer_id, c_name: params[:c_name], ename: params[:ename], e_id: @employee_id, daystart: params[:daystart], dayend: params[:dayend], kluan: params[:kluan], cdoan: params[:cdoan], hdieutri: params[:hdieutri])
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

  def updatesmall
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 2
			  @station = Station.find params[:id_station]
			  if params.has_key?(:id)
          @supplier = CheckInfo.find(params[:id])
          if @supplier.station_id == @station.id
            if @supplier.update(kluan: params[:kluan], cdoan: params[:cdoan], hdieutri: params[:hdieutri])
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
          @supplier = CheckInfo.find(params[:id])
          if @supplier.station_id == @station.id
            if @supplier.update(kluan: params[:kluan], cdoan: params[:cdoan], hdieutri: params[:hdieutri])
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

  def destroy
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 3
			  @station = Station.find params[:id_station]
			  if params.has_key?(:id)
			    @supplier = CheckInfo.find(params[:id])
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
			    @supplier = CheckInfo.find(params[:id])
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

  def list
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
			  @station = Station.find params[:id_station]
			  @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
          @data[0] = CheckInfo.where(station_id: @station.id, created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = CheckInfo.where(station_id: @station.id, created_at: start..fin)
        else
          @data[0] = CheckInfo.where(station_id: @station.id)
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
          @data[0] = CheckInfo.where(station_id: @station.id, created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = CheckInfo.where(station_id: @station.id, created_at: start..fin)
        else
          @data[0] = CheckInfo.where(station_id: @station.id)
        end
			  render json: @data
		  else
        redirect_to root_path
      end
    end
  end

  def search
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
        @station = Station.find params[:id_station]
        if params.has_key?(:ename)
          @supplier = CheckInfo.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id).group(:ename).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:c_name)
          @supplier = CheckInfo.where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id).group(:c_name).limit(5)
			    render json:@supplier
        elsif params.has_key?(:conclude)
				  @supplier = CheckInfo.where("conclude LIKE ? and station_id = ?" , "%#{params[:conclude]}%", @station.id).group(:conclude).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:cdoan)
				  @supplier = CheckInfo.where("cdoan LIKE ? and station_id = ?" , "%#{params[:cdoan]}%", @station.id).group(:cdoan).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:hdieutri)
				  @supplier = CheckInfo.where("hdieutri LIKE ? and station_id = ?" , "%#{params[:hdieutri]}%", @station.id).group(:hdieutri).limit(5)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:ename)
          @supplier = CheckInfo.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id).group(:ename).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:c_name)
          @supplier = CheckInfo.where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id).group(:c_name).limit(5)
			    render json:@supplier
        elsif params.has_key?(:conclude)
				  @supplier = CheckInfo.where("conclude LIKE ? and station_id = ?" , "%#{params[:conclude]}%", @station.id).group(:conclude).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:cdoan)
				  @supplier = CheckInfo.where("cdoan LIKE ? and station_id = ?" , "%#{params[:cdoan]}%", @station.id).group(:cdoan).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:hdieutri)
				  @supplier = CheckInfo.where("hdieutri LIKE ? and station_id = ?" , "%#{params[:hdieutri]}%", @station.id).group(:hdieutri).limit(5)
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
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
        else
          start = CheckInfo.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:ename)
          @supplier = CheckInfo.where(created_at: start..fin).where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:c_name)
          @supplier = CheckInfo.where(created_at: start..fin).where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:conclude)
				  @supplier = CheckInfo.where(created_at: start..fin).where("conclude LIKE ? and station_id = ?" , "%#{params[:conclude]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:cdoan)
				  @supplier = CheckInfo.where(created_at: start..fin).where("cdoan LIKE ? and station_id = ?" , "%#{params[:cdoan]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:hdieutri)
				  @supplier = CheckInfo.where(created_at: start..fin).where("hdieutri LIKE ? and station_id = ?" , "%#{params[:hdieutri]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:status)
				  @supplier = CheckInfo.where(created_at: start..fin).where("status = ? and station_id = ?" , params[:status], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:daystart) and params.has_key?(:dayend)
				  @supplier = CheckInfo.where(created_at: start..fin).where(" daystart <= ? and dayend => ? and station_id = ?" , "%#{params[:daystart]}%", "%#{params[:dayend]}%" , @station.id)
			    render json:@supplier
			  elsif params.has_key?(:daystart)
				  @supplier = CheckInfo.where(created_at: start..fin).where(" daystart <= ? and station_id = ?" , "%#{params[:daystart]}%" , @station.id)
			    render json:@supplier
			  elsif params.has_key?(:dayend)
				  @supplier = CheckInfo.where(created_at: start..fin).where(" dayend => ? and station_id = ?" , "%#{params[:dayend]}%" , @station.id)
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
          start = CheckInfo.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:ename)
          @supplier = CheckInfo.where(created_at: start..fin).where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:c_name)
          @supplier = CheckInfo.where(created_at: start..fin).where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:conclude)
				  @supplier = CheckInfo.where(created_at: start..fin).where("conclude LIKE ? and station_id = ?" , "%#{params[:conclude]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:cdoan)
				  @supplier = CheckInfo.where(created_at: start..fin).where("cdoan LIKE ? and station_id = ?" , "%#{params[:cdoan]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:hdieutri)
				  @supplier = CheckInfo.where(created_at: start..fin).where("hdieutri LIKE ? and station_id = ?" , "%#{params[:hdieutri]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:status)
				  @supplier = CheckInfo.where(created_at: start..fin).where("status = ? and station_id = ?" , params[:status], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:daystart) and params.has_key?(:dayend)
				  @supplier = CheckInfo.where(created_at: start..fin).where(" daystart <= ? and dayend => ? and station_id = ?" , "%#{params[:daystart]}%", "%#{params[:dayend]}%" , @station.id)
			    render json:@supplier
			  elsif params.has_key?(:daystart)
				  @supplier = CheckInfo.where(created_at: start..fin).where(" daystart <= ? and station_id = ?" , "%#{params[:daystart]}%" , @station.id)
			    render json:@supplier
			  elsif params.has_key?(:dayend)
				  @supplier = CheckInfo.where(created_at: start..fin).where(" dayend => ? and station_id = ?" , "%#{params[:dayend]}%" , @station.id)
			    render json:@supplier
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
          check_info = CheckInfo.find_by(id: params[:id], station_id: @station.id)
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
          check_info = CheckInfo.find_by(id: params[:id], station_id: @station.id)
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
			  if params.has_key?(:check_info_id)
			    check_info = CheckInfo.find_by(id: params[:check_info_id], station_id: @station.id)
          if check_info
            check_info.update(status: 3)
            ordermap = OrderMap.find_by(id: check_info.order_map_id, station_id: @station.id)
            if ordermap
              case ordermap.status
              when 1
                type = 4
              when 2
                type = 3
              else
                type = ordermap.status
              end
              ordermap.update(status: type)
            end
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
			  if params.has_key?(:check_info_id)
			    check_info = CheckInfo.find_by(id: params[:check_info_id], station_id: @station.id)
          if check_info
            check_info.update(status: 3)
            ordermap = OrderMap.find_by(id: check_info.order_map_id, station_id: @station.id)
            if ordermap
              case ordermap.status
              when 1
                type = 4
              when 2
                type = 3
              else
                type = ordermap.status
              end
              ordermap.update(status: type)
            end
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

end
