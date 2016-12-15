class MedicinePrescriptExternalController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy, :search, :find]
  
  def list
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
			  @station = Station.find params[:id_station]
			  @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
          @data[0] = MedicinePrescriptExternal.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicinePrescriptExternal.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicinePrescriptExternal.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicinePrescriptExternal.where(station_id: @station.id)
          @data[1] = MedicineGroup.all
          @data[2] = MedicineType.all
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
          @data[0] = MedicinePrescriptExternal.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicinePrescriptExternal.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicinePrescriptExternal.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicinePrescriptExternal.where(station_id: @station.id)
          @data[1] = MedicineGroup.all
          @data[2] = MedicineType.all
        end
			  render json: @data
		  else
        redirect_to root_path
      end
    end
  end

  def create
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 1
			  @station = Station.find params[:id_station]
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
					for external_record in JSON.parse(params[:list_external_record]) do
            @sample_id = MedicineSample.find_by(id: external_record["sample_id"], name: external_record["name"], station_id: @station.id)
		        if !@sample_id.nil?
				      @sample_id = @sample_id.id
		        end
            @company_id = MedicineCompany.find_by(id: external_record["company_id"], name: external_record["company"], station_id: @station.id)
		        if !@company_id.nil?
				      @company_id = @company_id.id
		        end
            @externalrecord = MedicineExternalRecord.new(station_id: @station.id, cname: @supplier.cname, customer_id: @supplier.customer_id, script_id: @supplier.id, script_code: @supplier.code, name: external_record["name"], sample_id: @sample_id, company: external_record["company"], company_id: @company_id, amount: external_record["amount"], remark: external_record["remark"], price: external_record["price"], total: external_record["total"])
            @externalrecord.save
          end
				  render json: @supplier
				else
					render json: @supplier.errors, status: :unprocessable_entity
				end
		  else
        head :no_content
      end
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
					for external_record in JSON.parse(params[:list_external_record]) do
            @sample_id = MedicineSample.find_by(id: external_record["sample_id"], name: external_record["name"], station_id: @station.id)
		        if !@sample_id.nil?
				      @sample_id = @sample_id.id
		        end
            @company_id = MedicineCompany.find_by(id: external_record["company_id"], name: external_record["company"], station_id: @station.id)
		        if !@company_id.nil?
				      @company_id = @company_id.id
		        end
            @externalrecord = MedicineExternalRecord.new(station_id: @station.id, cname: @supplier.cname, customer_id: @supplier.customer_id, script_id: @supplier.id, script_code: @supplier.code, name: external_record["name"], sample_id: @sample_id, company: external_record["company"], company_id: @company_id, amount: external_record["amount"], remark: external_record["remark"], price: external_record["price"], total: external_record["total"])
            @externalrecord.save
          end
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
      if current_user.check_permission params[:id_station], params[:table_id], 2
        @station = Station.find params[:id_station]
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
		        if @supplier.update( code: params[:code], customer_id: @customer_id, cname: params[:cname], employee_id: @employee_id, ename: params[:ename], result_id: params[:result_id], number_id: params[:number_id], date: params[:date], address: params[:address], remark: params[:remark])
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
		        if @supplier.update( code: params[:code], customer_id: @customer_id, cname: params[:cname], employee_id: @employee_id, ename: params[:ename], result_id: params[:result_id], number_id: params[:number_id], date: params[:date], address: params[:address], remark: params[:remark])
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
			    @supplier = MedicinePrescriptExternal.find(params[:id])
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
      if current_user.check_permission params[:id_station], params[:table_id], 4
        @station = Station.find params[:id_station]
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
        head :no_content
      end
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
          start = MedicinePrescriptExternal.order(created_at: :asc).first.created_at
          fin = Time.now
        end
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
          start = MedicinePrescriptExternal.order(created_at: :asc).first.created_at
          fin = Time.now
        end
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
