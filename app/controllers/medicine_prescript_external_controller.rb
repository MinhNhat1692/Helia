class MedicinePrescriptExternalController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy, :search, :find]
  
  def list
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = MedicinePrescriptExternal.where(station_id: @station.id)
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
		    @customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		    if !@customer_id.nil?
					@customer_id = @customer_id.id
				end
		    @employee_id = Employee.find_by(id: params[:employee_id], ename: params[:ename], station_id: @station.id)
		    if !@employee_id.nil?
					@employee_id = @employee_id.id
		    end
		    @supplier = MedicinePrescriptExternal.new(station_id: @station.id, code: params[:code], customer_id: @customer_id, cname: params[:cname], employee_id: @employee_id, ename: params[:ename], result_id: params[:result_id], number_id: params[:number_id], date: params[:date], address: params[:address], remark: params[:remark])
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
          @supplier = MedicinePrescriptExternal.find(params[:id])
			    if @supplier.station_id == @station.id
            @customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		        if !@customer_id.nil?
  					  @customer_id = @customer_id.id
	  			  end
		        @employee_id = Employee.find_by(id: params[:employee_id], ename: params[:ename], station_id: @station.id)
		        if !@employee_id.nil?
				  	  @employee_id = @employee_id.id
		        end
		        if @supplier.update(code: params[:code], customer_id: @customer_id, cname: params[:cname], employee_id: @employee_id, ename: params[:ename], result_id: params[:result_id], number_id: params[:number_id], date: params[:date], address: params[:address], remark: params[:remark])
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
			    @supplier = MedicinePrescriptExternal.find(params[:id])
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
        if params.has_key?(:code)
          @supplier = MedicinePrescriptExternal.where("code LIKE ? and station_id = ?" , "%#{params[:code]}%", @station.id).group(:code).limit(3)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicinePrescriptExternal.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:ename)
				  @supplier = MedicinePrescriptExternal.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id).group(:ename).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:number_id)
				  @supplier = MedicinePrescriptExternal.where("number_id LIKE ? and station_id = ?" , "%#{params[:number_id]}%", @station.id).group(:number_id).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:address)
				  @supplier = MedicinePrescriptExternal.where("address LIKE ? and station_id = ?" , "%#{params[:address]}%", @station.id).group(:address).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicinePrescriptExternal.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
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
        if params.has_key?(:code)
          @supplier = MedicinePrescriptExternal.where("code LIKE ? and station_id = ?" , "%#{params[:code]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicinePrescriptExternal.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:ename)
				  @supplier = MedicinePrescriptExternal.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:number_id)
				  @supplier = MedicinePrescriptExternal.where("number_id LIKE ? and station_id = ?" , "%#{params[:number_id]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:address)
				  @supplier = MedicinePrescriptExternal.where("address LIKE ? and station_id = ?" , "%#{params[:address]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicinePrescriptExternal.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:result_id)
				  @supplier = MedicinePrescriptExternal.where("result_id = ? and station_id = ?" , params[:result_id], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:date)
				  @supplier = MedicinePrescriptExternal.where("date = ? and station_id = ?" , params[:date], @station.id)
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
