class MedicineExternalRecordController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy, :search, :find]
  
  def list
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = MedicineExternalRecord.where(station_id: @station.id)
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
		    @customer_id = nil
		    @script_id = nil
		    if params.has_key?(:customer_id) 
		      @customerrecord = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		      if @custommerrecord != nil
            @customer_id = @custommerrecord.id
          end
		    end
		    if params.has_key?(:script_id)
		      @script = MedicinePrescriptExternal.find_by(id: params[:script_id], code: params[:script_code], station_id: @station.id)
		      if @script != nil
            @script_id = @script.id
          end
		    end
		    @supplier = MedicineExternalRecord.new(station_id: @station.id, customer_id: @customer_id, cname: params[:cname], script_id: @script_id, script_code: params[:script_code], name: params[:name], amount: params[:amount], remark: params[:remark], company: params[:company], price: params[:price], total: params[:total])
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
          @supplier = MedicineExternalRecord.find(params[:id])
			    if @supplier.station_id == @station.id
            @customer_id = nil
		        @script_id = nil
		        if params.has_key?(:customer_id) 
		          @customerrecord = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		          if @custommerrecord != nil
                @customer_id = @custommerrecord.id
              end
		        end
		        if params.has_key?(:script_id)
		          @script = MedicinePrescriptExternal.find_by(id: params[:script_id], code: params[:script_code], station_id: @station.id)
		          if @script != nil
                @script_id = @script.id
              end
		        end
		        if @supplier.update(customer_id: @customer_id, cname: params[:cname], script_id: @script_id, script_code: params[:script_code], name: params[:name], amount: params[:amount], remark: params[:remark], company: params[:company], price: params[:price], total: params[:total])
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
			    @supplier = MedicineExternalRecord.find(params[:id])
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
          @supplier = MedicineExternalRecord.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id).group(:name).limit(3)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicineExternalRecord.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:script_code)
				  @supplier = MedicineExternalRecord.where("script_code LIKE ? and station_id = ?" , "%#{params[:script_code]}%", @station.id).group(:script_code).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineExternalRecord.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineExternalRecord.where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id).group(:company).limit(3)
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
          @supplier = MedicineExternalRecord.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicineExternalRecord.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:script_code)
				  @supplier = MedicineExternalRecord.where("script_code LIKE ? and station_id = ?" , "%#{params[:script_code]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineExternalRecord.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineExternalRecord.where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:amount)
				  @supplier = MedicineExternalRecord.where("amount = ? and station_id = ?" , params[:amount], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:price)
				  @supplier = MedicineExternalRecord.where("price = ? and station_id = ?" , params[:price], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:total)
				  @supplier = MedicineExternalRecord.where("total = ? and station_id = ?" , params[:total], @station.id)
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
