class DoctorCheckInfoController < ApplicationController
  before_action :logged_in_user, only: [:update, :list, :destroy, :search, :find]
  
  def update
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 2
		    @station = Station.find params[:id_station]
		    if params.has_key?(:id)
          @supplier = DoctorCheckInfo.find(params[:id])
          if @supplier.station_id == @station.id
						@customer_id = CustomerRecord.find_by(id: params[:c_id], cname: params[:c_name], station_id: @station.id)
		        if !@customer_id.nil?
				      @customer_id = @customer_id.id
  		      end
            @employee_id = Employee.find_by(id: params[:e_id], ename: params[:ename], station_id: @station.id)
		        if !@employee_id.nil?
			        @employee_id = @employee_id.id
  		      end
		        if @supplier.update(daycheck: params[:daycheck], c_id: @customer_id, c_name: params[:c_name], ename: params[:ename], e_id: @employee_id, qtbenhly: params[:qtbenhly], klamsang: params[:klamsang], nhiptim: params[:nhiptim], nhietdo: params[:nhietdo], hamin: params[:hamin], hamax: params[:hamax], ntho: params[:ntho], cnang: params[:cnang], cao: params[:cao], cdbandau: params[:cdbandau], bktheo: params[:bktheo], cdicd: params[:cdicd], kluan: params[:kluan])
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
          @supplier = DoctorCheckInfo.find(params[:id])
          if @supplier.station_id == @station.id
						@customer_id = CustomerRecord.find_by(id: params[:c_id], cname: params[:c_name], station_id: @station.id)
		        if !@customer_id.nil?
				      @customer_id = @customer_id.id
  		      end
            @employee_id = Employee.find_by(id: params[:e_id], ename: params[:ename], station_id: @station.id)
		        if !@employee_id.nil?
			        @employee_id = @employee_id.id
  		      end
		        if @supplier.update(daycheck: params[:daycheck], c_id: @customer_id, c_name: params[:c_name], ename: params[:ename], e_id: @employee_id, qtbenhly: params[:qtbenhly], klamsang: params[:klamsang], nhiptim: params[:nhiptim], nhietdo: params[:nhietdo], hamin: params[:hamin], hamax: params[:hamax], ntho: params[:ntho], cnang: params[:cnang], cao: params[:cao], cdbandau: params[:cdbandau], bktheo: params[:bktheo], cdicd: params[:cdicd], kluan: params[:kluan])
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
          @supplier = DoctorCheckInfo.find(params[:id])
          if @supplier.station_id == @station.id
						if @supplier.update(qtbenhly: params[:qtbenhly], klamsang: params[:klamsang], nhiptim: params[:nhiptim], nhietdo: params[:nhietdo], hamin: params[:hamin], hamax: params[:hamax], ntho: params[:ntho], cnang: params[:cnang], cao: params[:cao], cdbandau: params[:cdbandau], bktheo: params[:bktheo], cdicd: params[:cdicd], kluan: params[:kluan])
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
          @supplier = DoctorCheckInfo.find(params[:id])
          if @supplier.station_id == @station.id
						if @supplier.update(qtbenhly: params[:qtbenhly], klamsang: params[:klamsang], nhiptim: params[:nhiptim], nhietdo: params[:nhietdo], hamin: params[:hamin], hamax: params[:hamax], ntho: params[:ntho], cnang: params[:cnang], cao: params[:cao], cdbandau: params[:cdbandau], bktheo: params[:bktheo], cdicd: params[:cdicd], kluan: params[:kluan])
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
		      @supplier = DoctorCheckInfo.find(params[:id])
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
		      @supplier = DoctorCheckInfo.find(params[:id])
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
          @data[0] = DoctorCheckInfo.where(station_id: @station.id, created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = DoctorCheckInfo.where(station_id: @station.id, created_at: start..fin)
        else
          @data[0] = DoctorCheckInfo.where(station_id: @station.id)
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
          @data[0] = DoctorCheckInfo.where(station_id: @station.id, created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = DoctorCheckInfo.where(station_id: @station.id, created_at: start..fin)
        else
          @data[0] = DoctorCheckInfo.where(station_id: @station.id)
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
          @supplier = DoctorCheckInfo.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id).group(:ename).limit(5)
		      render json:@supplier
        elsif params.has_key?(:c_name)
		      @supplier = DoctorCheckInfo.where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id).group(:c_name).limit(5)
		      render json:@supplier
        elsif params.has_key?(:qtbenhly)
		      @supplier = DoctorCheckInfo.where("qtbenhly LIKE ? and station_id = ?" , "%#{params[:qtbenhly]}%", @station.id).group(:qtbenhly).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:klamsang)
		      @supplier = DoctorCheckInfo.where("klamsang LIKE ? and station_id = ?" , "%#{params[:klamsang]}%", @station.id).group(:klamsang).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:cdbandau)
		      @supplier = DoctorCheckInfo.where("cdbandau LIKE ? and station_id = ?" , "%#{params[:cdbandau]}%", @station.id).group(:cdbandau).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:bktheo)
		      @supplier = DoctorCheckInfo.where("bktheo LIKE ? and station_id = ?" , "%#{params[:bktheo]}%", @station.id).group(:bktheo).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:cdicd)
		      @supplier = DoctorCheckInfo.where("cdicd LIKE ? and station_id = ?" , "%#{params[:cdicd]}%", @station.id).group(:cdicd).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:kluan)
		      @supplier = DoctorCheckInfo.where("kluan LIKE ? and station_id = ?" , "%#{params[:kluan]}%", @station.id).group(:kluan).limit(5)
		      render json:@supplier
		    end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:ename)
          @supplier = DoctorCheckInfo.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id).group(:ename).limit(5)
		      render json:@supplier
        elsif params.has_key?(:c_name)
		      @supplier = DoctorCheckInfo.where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id).group(:c_name).limit(5)
		      render json:@supplier
        elsif params.has_key?(:qtbenhly)
		      @supplier = DoctorCheckInfo.where("qtbenhly LIKE ? and station_id = ?" , "%#{params[:qtbenhly]}%", @station.id).group(:qtbenhly).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:klamsang)
		      @supplier = DoctorCheckInfo.where("klamsang LIKE ? and station_id = ?" , "%#{params[:klamsang]}%", @station.id).group(:klamsang).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:cdbandau)
		      @supplier = DoctorCheckInfo.where("cdbandau LIKE ? and station_id = ?" , "%#{params[:cdbandau]}%", @station.id).group(:cdbandau).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:bktheo)
		      @supplier = DoctorCheckInfo.where("bktheo LIKE ? and station_id = ?" , "%#{params[:bktheo]}%", @station.id).group(:bktheo).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:cdicd)
		      @supplier = DoctorCheckInfo.where("cdicd LIKE ? and station_id = ?" , "%#{params[:cdicd]}%", @station.id).group(:cdicd).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:kluan)
		      @supplier = DoctorCheckInfo.where("kluan LIKE ? and station_id = ?" , "%#{params[:kluan]}%", @station.id).group(:kluan).limit(5)
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
          start = MedicineBillRecord.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:ename)
          @supplier = DoctorCheckInfo.where(created_at: start..fin).where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
		      render json:@supplier
        elsif params.has_key?(:c_name)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id)
		      render json:@supplier
        elsif params.has_key?(:qtbenhly)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("qtbenhly LIKE ? and station_id = ?" , "%#{params[:qtbenhly]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:klamsang)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("klamsang LIKE ? and station_id = ?" , "%#{params[:klamsang]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:cdbandau)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("cdbandau LIKE ? and station_id = ?" , "%#{params[:cdbandau]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:bktheo)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("bktheo LIKE ? and station_id = ?" , "%#{params[:bktheo]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:cdicd)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("cdicd LIKE ? and station_id = ?" , "%#{params[:cdicd]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:kluan)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("kluan LIKE ? and station_id = ?" , "%#{params[:kluan]}%", @station.id)
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
          start = MedicineBillRecord.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:ename)
          @supplier = DoctorCheckInfo.where(created_at: start..fin).where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
		      render json:@supplier
        elsif params.has_key?(:c_name)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id)
		      render json:@supplier
        elsif params.has_key?(:qtbenhly)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("qtbenhly LIKE ? and station_id = ?" , "%#{params[:qtbenhly]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:klamsang)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("klamsang LIKE ? and station_id = ?" , "%#{params[:klamsang]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:cdbandau)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("cdbandau LIKE ? and station_id = ?" , "%#{params[:cdbandau]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:bktheo)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("bktheo LIKE ? and station_id = ?" , "%#{params[:bktheo]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:cdicd)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("cdicd LIKE ? and station_id = ?" , "%#{params[:cdicd]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:kluan)
		      @supplier = DoctorCheckInfo.where(created_at: start..fin).where("kluan LIKE ? and station_id = ?" , "%#{params[:kluan]}%", @station.id)
		      render json:@supplier
		    end
      else
        redirect_to root_path
      end
    end
  end
end
