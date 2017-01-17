class MedicineInternalRecordController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy, :search, :find]
  
  def list
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
			  @station = Station.find params[:id_station]
			  @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
          @data[0] = MedicineInternalRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicineInternalRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicineInternalRecord.where(station_id: @station.id)
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
          @data[0] = MedicineInternalRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicineInternalRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicineInternalRecord.where(station_id: @station.id)
          @data[1] = MedicineGroup.all
          @data[2] = MedicineType.all
        end
			  render json: @data
		  else
        redirect_to root_path
      end
    end
  end

  # d: date, n_id: noid, s_id: signid, sam_id: sample_id, sup_id: supplier_id, r: records quantity, s: script quantity
  def summary
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
			  @station = Station.find params[:id_station]
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start_date = n.days.ago.to_date
          end_date = Time.now.to_date + 1
          @data[0] = MedicineInternalRecord.count_by_day start_date, end_date, @station.id
          @data[1] = MedicineExternalRecord.count_by_day start_date, end_date, @station.id
          @data[2] = MedicineInternalRecord.statistic_by_day start_date, end_date, @station.id
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          @data[0] = MedicineInternalRecord.count_by_day start_date, end_date, @station.id
          @data[1] = MedicineExternalRecord.count_by_day start_date, end_date, @station.id
          @data[2] = MedicineInternalRecord.statistic_by_day start_date, end_date, @station.id
          render json: @data
        else
          redirect_to root_path
        end
      else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start_date = n.days.ago.to_date
          end_date = Time.now.to_date + 1
          @data[0] = MedicineInternalRecord.count_by_day start_date, end_date, @station.id
          @data[1] = MedicineExternalRecord.count_by_day start_date, end_date, @station.id
          @data[2] = MedicineInternalRecord.statistic_by_day start_date, end_date, @station.id
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          @data[0] = MedicineInternalRecord.count_by_day start_date, end_date, @station.id
          @data[1] = MedicineExternalRecord.count_by_day start_date, end_date, @station.id
          @data[2] = MedicineInternalRecord.statistic_by_day start_date, end_date, @station.id
          render json: @data
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    end
  end

  def sub_summary
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
        if params.has_key?(:date)
          n = params[:date].to_i
          start_date = n.days.ago.to_date
          end_date = Time.now.to_date + 1
          if params.has_key?(:med_name) && params.has_key?(:company) && params.has_key?(:price)
            data = MedicineInternalRecord.statistic_records start_date, end_date, params[:med_name], params[:company], params[:price], @station.id
            render json: data
          else
            redirect_to root_path
          end
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          if params.has_key?(:med_name) && params.has_key?(:company) && params.has_key?(:price)
            data = MedicineInternalRecord.statistic_records start_date, end_date, params[:med_name], params[:company], params[:price]
            render json: data
          else
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start_date = n.days.ago.to_date
          end_date = Time.now.to_date + 1
          if params.has_key?(:med_name) && params.has_key?(:company) && params.has_key?(:price)
            data = MedicineInternalRecord.statistic_records start_date, end_date, params[:med_name], params[:company], params[:price], @station.id
            render json: data
          else
            redirect_to root_path
          end
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          if params.has_key?(:med_name) && params.has_key?(:company) && params.has_key?(:price)
            data = MedicineInternalRecord.statistic_records start_date, end_date, params[:med_name], params[:company], params[:price], @station.id
            render json: data
          else
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
      end
    end
  end
  
  def statistic
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
			  @station = Station.find params[:id_station]
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start_date = n.days.ago.beginning_of_day.strftime("%Y-%m-%D %H:%M:%S")
          end_date = Time.now.to_date + 1
          @data[0] = MedicineInternalRecord.statistic_by_sample start_date, end_date, @station.id
          @data[1] = MedicineBillRecord.origin_price start_date, end_date, @station.id
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date.end_of_day.strftime("%Y-%m-%D %H:%M:%S")
          @data[0] = MedicineInternalRecord.statistic_by_sample start_date, end_date, @station.id
          @data[1] = MedicineBillRecord.origin_price start_date, end_date, @station.id
          render json: @data
        else
          redirect_to root_path
        end
      else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start_date = n.days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          end_date = Time.now.to_date + 1
          @data[0] = MedicineInternalRecord.statistic_by_sample start_date, end_date, @station.id
          @data[1] = MedicineBillRecord.origin_price start_date, end_date, @station.id
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          @data[0] = MedicineInternalRecord.statistic_by_sample start_date, end_date, @station.id
          @data[1] = MedicineBillRecord.origin_price start_date, end_date, @station.id
          render json: @data
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    end
  end

  def sale
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
			  @station = Station.find params[:id_station]
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start_date = n.days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          end_date = Time.now.to_date + 1
          start = (2*n).days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          fin = (n + 1).days.ago.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          @data[0] = MedicineInternalRecord.medicine_sale start_date, end_date, @station.id
          @data[1] = OrderMap.total_sale start_date, end_date, @station.id
          @data[2] = MedicineInternalRecord.medicine_sale start, fin, @station.id
          @data[3] = OrderMap.total_sale start, fin, @station.id
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          n = end_date.to_date - start_date
          start = start_date - n
          fin = (start_date - 1).end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          @data[0] = MedicineInternalRecord.medicine_sale start_date, end_date, @station.id
          @data[1] = OrderMap.total_sale start_date, end_date, @station.id
          @data[2] = MedicineInternalRecord.medicine_sale start, fin, @station.id
          @data[3] = OrderMap.total_sale start, fin, @station.id
          render json: @data
        else
          redirect_to root_path
        end
      else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start_date = n.days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          end_date = Time.now.to_date + 1
          start = (2*n).days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
          fin = (n + 1).days.ago.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          @data[0] = MedicineInternalRecord.medicine_sale start_date, end_date, @station.id
          @data[1] = OrderMap.total_sale start_date, end_date, @station.id
          @data[2] = MedicineInternalRecord.medicine_sale start, fin, @station.id
          @data[3] = OrderMap.total_sale start, fin, @station.id
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          n = end_date.to_date - start_date
          start = start_date - n
          fin = (start_date - 1).end_of_day.strftime("%Y-%m-%d %H:%M:%S")
          @data[0] = MedicineInternalRecord.medicine_sale start_date, end_date, @station.id
          @data[1] = OrderMap.total_sale start_date, end_date, @station.id
          @data[2] = MedicineInternalRecord.medicine_sale start, fin, @station.id
          @data[3] = OrderMap.total_sale start, fin, @station.id
          render json: @data
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    end
  end

  def create
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 1
			  @station = Station.find params[:id_station]
		    @customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		    if !@customer_id.nil?
					@customer_id = @customer_id.id
				end
		    @script_id = MedicinePrescriptInternal.find_by(id: params[:script_id], code: params[:script_code], station_id: @station.id)
		    if !@script_id.nil?
					@script_id = @script_id.id
		    end
		    @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		    if !@sample_id.nil?
					@sample_id = @sample_id.id
		    end
		    @company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		    if !@company_id.nil?
				  @company_id = @company_id.id
		    end
		    @supplier = MedicineInternalRecord.new(station_id: @station.id, customer_id: @customer_id, cname: params[:cname], sample_id: @sample_id, script_id: @script_id, script_code: params[:script_code], name: params[:name], amount: params[:amount], remark: params[:remark], company_id: @company_id, company: params[:company], price: params[:price], tpayment: params[:tpayment], status: params[:status])
				if @supplier.save
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
		    @script_id = MedicinePrescriptInternal.find_by(id: params[:script_id], code: params[:script_code], station_id: @station.id)
		    if !@script_id.nil?
					@script_id = @script_id.id
		    end
		    @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		    if !@sample_id.nil?
					@sample_id = @sample_id.id
		    end
		    @company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		    if !@company_id.nil?
				  @company_id = @company_id.id
		    end
		    @supplier = MedicineInternalRecord.new(station_id: @station.id, customer_id: @customer_id, cname: params[:cname], sample_id: @sample_id, script_id: @script_id, script_code: params[:script_code], name: params[:name], amount: params[:amount], remark: params[:remark], company_id: @company_id, company: params[:company], price: params[:price], tpayment: params[:tpayment], status: params[:status])
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
      if current_user.check_permission params[:id_station], 2, 2
        @station = Station.find params[:id_station]
        if params.has_key?(:id)
          @supplier = MedicineInternalRecord.find(params[:id])
			    if @supplier.station_id == @station.id
						@customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		        if !@customer_id.nil?
					    @customer_id = @customer_id.id
				    end
		        @script_id = MedicinePrescriptInternal.find_by(id: params[:script_id], code: params[:script_code], station_id: @station.id)
		        if !@script_id.nil?
					    @script_id = @script_id.id
		        end
		        @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		        if !@sample_id.nil?
					    @sample_id = @sample_id.id
		        end
		        @company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		        if !@company_id.nil?
				      @company_id = @company_id.id
		        end
		        if @supplier.update(customer_id: @customer_id, cname: params[:cname], sample_id: @sample_id, script_id: @script_id, script_code: params[:script_code], name: params[:name], amount: params[:amount], remark: params[:remark], company_id: @company_id, company: params[:company], price: params[:price], tpayment: params[:tpayment], status: params[:status])
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
          @supplier = MedicineInternalRecord.find(params[:id])
			    if @supplier.station_id == @station.id
						@customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		        if !@customer_id.nil?
					    @customer_id = @customer_id.id
				    end
		        @script_id = MedicinePrescriptInternal.find_by(id: params[:script_id], code: params[:script_code], station_id: @station.id)
		        if !@script_id.nil?
					    @script_id = @script_id.id
		        end
		        @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		        if !@sample_id.nil?
					    @sample_id = @sample_id.id
		        end
		        @company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		        if !@company_id.nil?
				      @company_id = @company_id.id
		        end
		        if @supplier.update(customer_id: @customer_id, cname: params[:cname], sample_id: @sample_id, script_id: @script_id, script_code: params[:script_code], name: params[:name], amount: params[:amount], remark: params[:remark], company_id: @company_id, company: params[:company], price: params[:price], tpayment: params[:tpayment], status: params[:status])
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
      if current_user.check_permission params[:id_station], 2, 3
			  @station = Station.find params[:id_station]
			  if params.has_key?(:id)
			    @supplier = MedicineInternalRecord.find(params[:id])
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
			    @supplier = MedicineInternalRecord.find(params[:id])
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
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
        if params.has_key?(:name)
          @supplier = MedicineInternalRecord.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id).group(:name).limit(3)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicineInternalRecord.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:script_code)
				  @supplier = MedicineInternalRecord.where("script_code LIKE ? and station_id = ?" , "%#{params[:script_code]}%", @station.id).group(:script_code).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineInternalRecord.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineInternalRecord.where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id).group(:company).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:noid)
				  @supplier = MedicineInternalRecord.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineInternalRecord.where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id).group(:signid).limit(3)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:name)
          @supplier = MedicineInternalRecord.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id).group(:name).limit(3)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicineInternalRecord.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:script_code)
				  @supplier = MedicineInternalRecord.where("script_code LIKE ? and station_id = ?" , "%#{params[:script_code]}%", @station.id).group(:script_code).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineInternalRecord.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineInternalRecord.where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id).group(:company).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:noid)
				  @supplier = MedicineInternalRecord.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineInternalRecord.where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id).group(:signid).limit(3)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
  end

  def find
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
        else
          start = MedicineInternalRecord.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:name)
          @supplier = MedicineInternalRecord.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:script_code)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("script_code LIKE ? and station_id = ?" , "%#{params[:script_code]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:noid)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:amount)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("amount = ? and station_id = ?" , params[:signid], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:price)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("price = ? and station_id = ?" , params[:price], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:discount)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("discount = ? and station_id = ?" , params[:discount], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:tpayment)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:status)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("status = ? and station_id = ?" , params[:status], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:script_id)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("script_id = ? and station_id = ?" , params[:script_id], @station.id)
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
          start = MedicineInternalRecord.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:name)
          @supplier = MedicineInternalRecord.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:script_code)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("script_code LIKE ? and station_id = ?" , "%#{params[:script_code]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:noid)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:amount)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("amount = ? and station_id = ?" , params[:signid], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:price)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("price = ? and station_id = ?" , params[:price], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:discount)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("discount = ? and station_id = ?" , params[:discount], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:tpayment)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:status)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("status = ? and station_id = ?" , params[:status], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:script_id)
				  @supplier = MedicineInternalRecord.where(created_at: start..fin).where("script_id = ? and station_id = ?" , params[:script_id], @station.id)
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
