class CheckInfoController < ApplicationController
  before_action :logged_in_user, only: [:update, :list, :destroy, :search, :find]
  
  def update
    if params.has_key?(:id_station)
      redirect_to root_path
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

  def destroy
    if params.has_key?(:id_station)
      redirect_to root_path
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
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = CheckInfo.where(station_id: @station.id).order(updated_at: :desc).limit(200)
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
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:ename)
          @supplier = CheckInfo.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:c_name)
          @supplier = CheckInfo.where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:conclude)
				  @supplier = CheckInfo.where("conclude LIKE ? and station_id = ?" , "%#{params[:conclude]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:cdoan)
				  @supplier = CheckInfo.where("cdoan LIKE ? and station_id = ?" , "%#{params[:cdoan]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:hdieutri)
				  @supplier = CheckInfo.where("hdieutri LIKE ? and station_id = ?" , "%#{params[:hdieutri]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:status)
				  @supplier = CheckInfo.where("status = ? and station_id = ?" , params[:status], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:daystart) and params.has_key?(:dayend)
				  @supplier = CheckInfo.where(" daystart <= ? and dayend => ? and station_id = ?" , "%#{params[:daystart]}%", "%#{params[:dayend]}%" , @station.id)
			    render json:@supplier
			  elsif params.has_key?(:daystart)
				  @supplier = CheckInfo.where(" daystart <= ? and station_id = ?" , "%#{params[:daystart]}%" , @station.id)
			    render json:@supplier
			  elsif params.has_key?(:dayend)
				  @supplier = CheckInfo.where(" dayend => ? and station_id = ?" , "%#{params[:dayend]}%" , @station.id)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
  end
end
