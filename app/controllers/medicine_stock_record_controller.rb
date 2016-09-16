class MedicineStockRecordController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy, :search, :find]
  
  def list
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = MedicineStockRecord.where(station_id: @station.id)
			  render json: @data
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
		    @supplier = MedicineStockRecord.new(station_id: @station.id, typerecord: params[:typerecord], name: params[:name], noid: params[:noid], signid: params[:signid], amount: params[:amount], expire: params[:expire], supplier: params[:supplier], remark: params[:remark], internal_record_id: params[:internal_record_id], bill_in_id: params[:bill_in_id], internal_record_code: params[:internal_record_code], bill_in_code: params[:bill_in_code])
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

  def update
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:id)
          @supplier = MedicineStockRecord.find(params[:id])
			    if @supplier.station_id == @station.id
            if @supplier.update(typerecord: params[:typerecord], name: params[:name], noid: params[:noid], signid: params[:signid], amount: params[:amount], expire: params[:expire], supplier: params[:supplier], remark: params[:remark], internal_record_id: params[:internal_record_id], bill_in_id: params[:bill_in_id], internal_record_code: params[:internal_record_code], bill_in_code: params[:bill_in_code])
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
			    @supplier = MedicineStockRecord.find(params[:id])
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
        if params.has_key?(:name)
          @supplier = MedicineStockRecord.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id).group(:name).limit(3)
			    render json:@supplier
        elsif params.has_key?(:noid)
				  @supplier = MedicineStockRecord.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineStockRecord.where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id).group(:signid).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:supplier)
				  @supplier = MedicineStockRecord.where("supplier LIKE ? and station_id = ?" , "%#{params[:supplier]}%", @station.id).group(:supplier).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:bill_in_code)
				  @supplier = MedicineStockRecord.where("bill_in_code LIKE ? and station_id = ?" , "%#{params[:bill_in_code]}%", @station.id).group(:bill_in_code).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:internal_record_code)
				  @supplier = MedicineStockRecord.where("internal_record_code LIKE ? and station_id = ?" , "%#{params[:internal_record_code]}%", @station.id).group(:internal_record_code).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineStockRecord.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
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
        if params.has_key?(:name)
          @supplier = MedicineStockRecord.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:noid)
				  @supplier = MedicineStockRecord.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineStockRecord.where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:supplier)
				  @supplier = MedicineStockRecord.where("supplier LIKE ? and station_id = ?" , "%#{params[:supplier]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:bill_in_code)
				  @supplier = MedicineStockRecord.where("bill_in_code LIKE ? and station_id = ?" , "%#{params[:bill_in_code]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:internal_record_code)
				  @supplier = MedicineStockRecord.where("internal_record_code LIKE ? and station_id = ?" , "%#{params[:internal_record_code]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineStockRecord.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:amount)
				  @supplier = MedicineStockRecord.where("amount = ? and station_id = ?" , params[:amount], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:expire)
				  @supplier = MedicineStockRecord.where("expire = ? and station_id = ?" , params[:expire], @station.id)
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
