class OrderMapController < ApplicationController
  before_action :logged_in_user, only: [:edit, :create, :list, :destroy, :search, :find]
  
  def edit
    if params.has_key?(:id_station)
      redirect_to root_path
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
	  	      if @supplier.update(station_id: @station.id, remark: params[:remark], customer_record_id: @customer_id, cname: params[:cname], service_id: @service_id, sername: params[:sername], status: params[:status], tpayment: params[:tpayment], discount: params[:discount], tpayout: [:tpayout])
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
      redirect_to root_path
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
		    @supplier = OrderMap.new(station_id: @station.id, remark: params[:remark], customer_record_id: @customer_id, cname: params[:cname], service_id: @service_id, sername: params[:sername], status: params[:status], tpayment: params[:tpayment], discount: params[:discount], tpayout: [:tpayout])
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
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = OrderMap.where(station_id: @station.id).order(updated_at: :desc).limit(200)
			  render json: @data
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
      redirect_to root_path
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
      redirect_to root_path
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
  
  private
  	# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end
end
