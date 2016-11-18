class BillInfoController < ApplicationController
  before_action :logged_in_user, only: [:update, :list, :destroy, :search, :find]
  
  def update
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 2
		    @station = Station.find params[:id_station]
		    if params.has_key?(:id)
          @supplier = BillInfo.find(params[:id])
          if @supplier.station_id == @station.id
						@customer_id = CustomerRecord.find_by(id: params[:c_id], cname: params[:c_name], station_id: @station.id)
		        if !@customer_id.nil?
				      @customer_id = @customer_id.id
  		      end
            if @supplier.update(remark: params[:remark], c_id: @customer_id, c_name: params[:c_name], dvi: params[:dvi], sluong: params[:sluong], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
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
          @supplier = BillInfo.find(params[:id])
          if @supplier.station_id == @station.id
						@customer_id = CustomerRecord.find_by(id: params[:c_id], cname: params[:c_name], station_id: @station.id)
		        if !@customer_id.nil?
				      @customer_id = @customer_id.id
  		      end
            if @supplier.update(remark: params[:remark], c_id: @customer_id, c_name: params[:c_name], dvi: params[:dvi], sluong: params[:sluong], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
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
		      @supplier = BillInfo.find(params[:id])
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
		      @supplier = BillInfo.find(params[:id])
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
		    @data[0] = BillInfo.where(station_id: @station.id).order(updated_at: :desc).limit(200)
		    @data[1] = OutsideCurrency.where(category: 1, station_id: nil)
		    render json: @data
      else
        head :no_content
      end
    else
      if has_station?
	      @station = Station.find_by(user_id: current_user.id)
		    @data = []
		    @data[0] = BillInfo.where(station_id: @station.id).order(updated_at: :desc).limit(200)
		    @data[1] = OutsideCurrency.where(category: 1, station_id: nil)
		    render json: @data
	    else
        redirect_to root_path
      end
    end
  end

  def search
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
        @station = Station.find params[:station]
        if params.has_key?(:remark)
          @supplier = BillInfo.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:c_name)
          @supplier = BillInfo.where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id).group(:c_name).limit(5)
		      render json:@supplier
		    end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:remark)
          @supplier = BillInfo.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(5)
		      render json:@supplier
		    elsif params.has_key?(:c_name)
          @supplier = BillInfo.where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id).group(:c_name).limit(5)
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
        if params.has_key?(:remark)
          @supplier = BillInfo.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
		      render json:@supplier
        elsif params.has_key?(:c_name)
          @supplier = BillInfo.where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:dvi)
		      @supplier = BillInfo.where("dvi = ? and station_id = ?" , params[:dvi], @station.id)
		      render json:@supplier
		    elsif params.has_key?(:sluong)
		      @supplier = BillInfo.where("sluong = ? and station_id = ?" , params[:sluong], @station.id)
		      render json:@supplier
		    elsif params.has_key?(:tpayment)
		      @supplier = BillInfo.where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id)
		      render json:@supplier
		    elsif params.has_key?(:discount)
		      @supplier = BillInfo.where("discount = ? and station_id = ?" , params[:discount], @station.id)
		      render json:@supplier
		    elsif params.has_key?(:tpayout)
		      @supplier = BillInfo.where("tpayout = ? and station_id = ?" , params[:tpayout], @station.id)
		      render json:@supplier
		    end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:remark)
          @supplier = BillInfo.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
		      render json:@supplier
        elsif params.has_key?(:c_name)
          @supplier = BillInfo.where("c_name LIKE ? and station_id = ?" , "%#{params[:c_name]}%", @station.id)
		      render json:@supplier
		    elsif params.has_key?(:dvi)
		      @supplier = BillInfo.where("dvi = ? and station_id = ?" , params[:dvi], @station.id)
		      render json:@supplier
		    elsif params.has_key?(:sluong)
		      @supplier = BillInfo.where("sluong = ? and station_id = ?" , params[:sluong], @station.id)
		      render json:@supplier
		    elsif params.has_key?(:tpayment)
		      @supplier = BillInfo.where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id)
		      render json:@supplier
		    elsif params.has_key?(:discount)
		      @supplier = BillInfo.where("discount = ? and station_id = ?" , params[:discount], @station.id)
		      render json:@supplier
		    elsif params.has_key?(:tpayout)
		      @supplier = BillInfo.where("tpayout = ? and station_id = ?" , params[:tpayout], @station.id)
		      render json:@supplier
		    end
      else
        redirect_to root_path
      end
    end
  end
end
