class BillInfoController < ApplicationController
  before_action :logged_in_user, only: [:update, :list, :destroy, :search, :find]
  
  def update
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
		    @station = Station.find_by(user_id: current_user.id)
		    if params.has_key?(:id)
          @supplier = BillInfo.find(params[:id])
          if @supplier.station_id == @station.id
            if @supplier.update(remark: params[:text], dvi: params[:dvi], sluong: params[:sluong], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout])
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
      redirect_to root_path
    else
      if has_station?
	      @station = Station.find_by(user_id: current_user.id)
		    @data = []
		    @data[0] = BillInfo.where(station_id: @station.id).order(updated_at: :desc).limit(200)
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
        if params.has_key?(:remark)
          @supplier = BillInfo.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(5)
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
        if params.has_key?(:remark)
          @supplier = BillInfo.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
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
		      @supplier = BillInfo.where("tpayout LIKE ? and station_id = ?" , params[:tpayout], @station.id)
		      render json:@supplier
		    end
      else
        redirect_to root_path
      end
    end
  end
end
