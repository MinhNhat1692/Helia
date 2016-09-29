class DoctorCheckInfoController < ApplicationController
  before_action :logged_in_user, only: [:update, :list, :destroy, :search, :find]
  
  def update
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
		    @station = Station.find_by(user_id: current_user.id)
		    if params.has_key?(:id)
          @supplier = DoctorCheckInfo.find(params[:id])
          if @supplier.station_id == @station.id
            @employee_id = Employee.find_by(id: params[:e_id], sname: params[:ename], station_id: @station.id)
		        if !@employee_id.nil?
			        @employee_id = @employee_id.id
  		      end
		        if @supplier.update(date: params[:date], ename: params[:ename], e_id: @employee_id, qtbenhly: params[:qtbenhly], klamsang: params[:klamsang], nhiptim: params[:nhaptim], nhietdo: params[:nhietdo], hamin: params[:hamin], hamax: params[:hamax], ntho: params[:ntho], cnang: params[:cnang], cao: params[:cao], cdbandau: params[:cdbandau], bktheo: params[:bktheo], cdicd: params[:cdicd], kluan: params[:kluan])
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
      redirect_to root_path
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
      redirect_to root_path
    else
      if has_station?
	      @station = Station.find_by(user_id: current_user.id)
		    @data = []
		    @data[0] = DoctorCheckInfo.where(station_id: @station.id).order(updated_at: :desc).limit(200)
		    render json: @data
	    else
        redirect_to root_path
      end
    end
  end

  def search
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:ename)
          @supplier = DoctorCheckInfo.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id).group(:ename).limit(5)
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
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:ename)
          @supplier = DoctorCheckInfo.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
		      render json:@supplier
        elsif params.has_key?(:qtbenhly)
		      @supplier = DoctorCheckInfo.where("qtbenhly LIKE ? and station_id = ?" , "%#{params[:qtbenhly]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:klamsang)
		      @supplier = DoctorCheckInfo.where("klamsang LIKE ? and station_id = ?" , "%#{params[:klamsang]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:cdbandau)
		      @supplier = DoctorCheckInfo.where("cdbandau LIKE ? and station_id = ?" , "%#{params[:cdbandau]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:bktheo)
		      @supplier = DoctorCheckInfo.where("bktheo LIKE ? and station_id = ?" , "%#{params[:bktheo]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:cdicd)
		      @supplier = DoctorCheckInfo.where("cdicd LIKE ? and station_id = ?" , "%#{params[:cdicd]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:kluan)
		      @supplier = DoctorCheckInfo.where("kluan LIKE ? and station_id = ?" , "%#{params[:kluan]}%", @station.id)
		      render json:@supplier
		    end
      else
        redirect_to root_path
      end
    end
  end
end