class MedicineStockRecordController < ApplicationController
  before_action :logged_in_user
  
  def list
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
			  @station = Station.find params[:id_station]
			  @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
          @data[0] = MedicineStockRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicineStockRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicineStockRecord.where(station_id: @station.id)
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
          @data[0] = MedicineStockRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicineStockRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicineStockRecord.where(station_id: @station.id)
          @data[1] = MedicineGroup.all
          @data[2] = MedicineType.all
        end
			  render json: @data
		  else
        redirect_to root_path
      end
    end
  end

  def summary #date and begin date, end date not affect this one, its look really fucked
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
        @data = []
        if params.has_key?(:date)
          @data[0] = MedicineStockRecord.sample_statistic @station.id
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          @data[0] = MedicineStockRecord.sample_statistic @station.id
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
          @data[0] = MedicineStockRecord.sample_statistic @station.id
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          @data[0] = MedicineStockRecord.sample_statistic @station.id
          render json: @data
        else
          redirect_to root_path
        end
      end
    end
  end

  def detail
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
        @data = []
        if params.has_key?(:date)
          if params.has_key?(:name) && params.has_key?(:sample_id)
            @data[0] = MedicineStockRecord.statistic_detail params[:name], params[:sample_id], @station.id
            render json: @data
          else
            redirect_to root_path
          end
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          if params.has_key?(:name) && params.has_key?(:sample_id)
            @data[0] = MedicineStockRecord.statistic_detail params[:name], params[:sample_id], @station.id
            render json: @data
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
          if params.has_key?(:name) && params.has_key?(:sample_id)
            @data[0] = MedicineStockRecord.statistic_detail params[:name], params[:sample_id], @station.id
            render json: @data
          else
            redirect_to root_path
          end
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          if params.has_key?(:name) && params.has_key?(:sample_id)
            @data[0] = MedicineStockRecord.statistic_detail params[:name], params[:sample_id], @station.id
            render json: @data
          else
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
      end
    end
  end

  def detail_2
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
        @data = []
        if params.has_key?(:date)
          if params.has_key?(:name) && params.has_key?(:sample_id) && params.has_key?(:no_id) && params.has_key?(:sign_id)
            start_date = params[:date].to_i.days.ago.to_date
            end_date = Time.now.to_date
            start = start_date.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
            fin = end_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
            @data[0] = MedicineStockRecord.sum_amount_at_date start_date, params[:name], 
              params[:sample_id], params[:no_id], params[:sign_id], @station.id
            statistic_by_day = MedicineStockRecord.sum_amount_between start, fin, params[:name], params[:sample_id], params[:no_id],
              params[:sign_id], @station.id
            statistic_by_day.each do |stat|
              @data[stat[:id]] = stat
            end
            render json: @data
          else
            redirect_to root_path
          end
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          if params.has_key?(:name) && params.has_key?(:sample_id) && params.has_key?(:no_id) && params.has_key?(:sign_id)
            start_date = params[:begin_date].to_date
            end_date = params[:end_date].to_date
            start = start_date.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
            fin = end_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
            @data[0] = MedicineStockRecord.sum_amount_at_date start_date, params[:name], 
              params[:sample_id], params[:no_id], params[:sign_id], @station.id
            statistic_by_day = MedicineStockRecord.sum_amount_between start, fin, params[:name], params[:sample_id], params[:no_id],
              params[:sign_id], @station.id
            statistic_by_day.each do |stat|
              @data[stat[:id]] = stat
            end
            render json: @data
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
          if params.has_key?(:name) && params.has_key?(:sample_id) && params.has_key?(:no_id) && params.has_key?(:sign_id)
            start_date = params[:date].to_i.days.ago.to_date
            end_date = Time.now.to_date
            start = start_date.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
            fin = end_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
            @data[0] = MedicineStockRecord.sum_amount_at_date start_date, params[:name], 
              params[:sample_id], params[:no_id], params[:sign_id], @station.id
            statistic_by_day = MedicineStockRecord.sum_amount_between start, fin, params[:name], params[:sample_id], params[:no_id],
              params[:sign_id], @station.id
            statistic_by_day.each do |stat|
              @data[stat[:id]] = stat
            end
            render json: @data
          else
            redirect_to root_path
          end
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          if params.has_key?(:name) && params.has_key?(:sample_id) && params.has_key?(:no_id) && params.has_key?(:sign_id)
            start_date = params[:begin_date].to_date
            end_date = params[:end_date].to_date
            start = start_date.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
            fin = end_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
            @data[0] = MedicineStockRecord.sum_amount_at_date start_date, params[:name], 
              params[:sample_id], params[:no_id], params[:sign_id], @station.id
            statistic_by_day = MedicineStockRecord.sum_amount_between start, fin, params[:name], params[:sample_id], params[:no_id],
              params[:sign_id], @station.id
            statistic_by_day.each do |stat|
              @data[stat[:id]] = stat
            end
            render json: @data
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
          if params.has_key?(:name) && params.has_key?(:sample_id) && params.has_key?(:supplier_id) && params.has_key?(:supplier)
            start_date = params[:date].to_i.days.ago.to_date
            end_date = Time.now.to_date
            start = start_date.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
            fin = end_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
            @data[0] = MedicineStockRecord.statistic_by_sample_and_supplier start, fin, params[:supplier], 
              params[:supplier_id], params[:name], params[:sample_id], @station.id
            render json: @data
          else
            redirect_to root_path
          end
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          if params.has_key?(:name) && params.has_key?(:sample_id) && params.has_key?(:supplier) && params.has_key?(:supplier_id)
            start_date = params[:begin_date].to_date
            end_date = params[:end_date].to_date
            start = start_date.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
            fin = end_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
            @data[0] = MedicineStockRecord.statistic_by_sample_and_supplier start, fin, params[:supplier], 
              params[:supplier_id], params[:name], params[:sample_id], @station.id
            render json: @data
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
          if params.has_key?(:name) && params.has_key?(:sample_id) && params.has_key?(:supplier) && params.has_key?(:supplier_id)
            start_date = params[:date].to_i.days.ago.to_date
            end_date = Time.now.to_date
            start = start_date.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
            fin = end_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
            @data[0] = MedicineStockRecord.statistic_by_sample_and_supplier start, fin, params[:supplier], 
              params[:supplier_id], params[:name], params[:sample_id], @station.id
            render json: @data
          else
            redirect_to root_path
          end
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          if params.has_key?(:name) && params.has_key?(:sample_id) && params.has_key?(:supplier) && params.has_key?(:supplier_id)
            start_date = params[:begin_date].to_date
            end_date = params[:end_date].to_date
            start = start_date.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
            fin = end_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
            @data[0] = MedicineStockRecord.statistic_by_sample_and_supplier start, fin, params[:supplier], 
              params[:supplier_id], params[:name], params[:sample_id], @station.id
            render json: @data
          else
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
      end
    end
  end

  def create
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 1
			  @station = Station.find params[:id_station]
			  @supplier_id = MedicineSupplier.find_by(id: params[:supplier_id], name: params[:supplier], station_id: @station.id)
		    if !@supplier_id.nil?
					@supplier_id = @supplier_id.id
				end
		    @script_id = MedicinePrescriptInternal.find_by(id: params[:internal_record_id], code: params[:internal_record_code], station_id: @station.id)
		    if !@script_id.nil?
					@script_id = @script_id.id
		    end
		    @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		    if !@sample_id.nil?
					@sample_id = @sample_id.id
		    end
		    @billin_id = MedicineBillIn.find_by(id: params[:bill_in_id], billcode: params[:bill_in_code], station_id: @station.id)
		    if !@billin_id.nil?
				  @billin_id = @billin_id.id
		    end
		    @supplier = MedicineStockRecord.new(station_id: @station.id, typerecord: params[:typerecord], sample_id: @sample_id, supplier_id: @supplier_id, name: params[:name], noid: params[:noid], signid: params[:signid], amount: params[:amount], expire: params[:expire], supplier: params[:supplier], remark: params[:remark], internal_record_id: @script_id, bill_in_id: @billin_id, internal_record_code: params[:internal_record_code], bill_in_code: params[:bill_in_code])
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
			  @supplier_id = MedicineSupplier.find_by(id: params[:supplier_id], name: params[:supplier], station_id: @station.id)
		    if !@supplier_id.nil?
					@supplier_id = @supplier_id.id
				end
		    @script_id = MedicinePrescriptInternal.find_by(id: params[:internal_record_id], code: params[:internal_record_code], station_id: @station.id)
		    if !@script_id.nil?
					@script_id = @script_id.id
		    end
		    @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		    if !@sample_id.nil?
					@sample_id = @sample_id.id
		    end
		    @billin_id = MedicineBillIn.find_by(id: params[:bill_in_id], billcode: params[:bill_in_code], station_id: @station.id)
		    if !@billin_id.nil?
				  @billin_id = @billin_id.id
		    end
		    @supplier = MedicineStockRecord.new(station_id: @station.id, typerecord: params[:typerecord], sample_id: @sample_id, supplier_id: @supplier_id, name: params[:name], noid: params[:noid], signid: params[:signid], amount: params[:amount], expire: params[:expire], supplier: params[:supplier], remark: params[:remark], internal_record_id: @script_id, bill_in_id: @billin_id, internal_record_code: params[:internal_record_code], bill_in_code: params[:bill_in_code])
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
          @supplier = MedicineStockRecord.find(params[:id])
			    if @supplier.station_id == @station.id
						@supplier_id = MedicineSupplier.find_by(id: params[:supplier_id], name: params[:supplier], station_id: @station.id)
		        if !@supplier_id.nil?
					    @supplier_id = @supplier_id.id
				    end
		        @script_id = MedicinePrescriptInternal.find_by(id: params[:internal_record_id], code: params[:internal_record_code], station_id: @station.id)
		        if !@script_id.nil?
					    @script_id = @script_id.id
		        end
		        @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		        if !@sample_id.nil?
					    @sample_id = @sample_id.id
		        end
		        @billin_id = MedicineBillIn.find_by(id: params[:bill_in_id], billcode: params[:bill_in_code], station_id: @station.id)
		        if !@billin_id.nil?
				      @billin_id = @billin_id.id
		        end
            if @supplier.update(typerecord: params[:typerecord], sample_id: @sample_id, supplier_id: @supplier_id, name: params[:name], noid: params[:noid], signid: params[:signid], amount: params[:amount], expire: params[:expire], supplier: params[:supplier], remark: params[:remark], internal_record_id: @script_id, bill_in_id: @billin_id, internal_record_code: params[:internal_record_code], bill_in_code: params[:bill_in_code])
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
          @supplier = MedicineStockRecord.find(params[:id])
			    if @supplier.station_id == @station.id
						@supplier_id = MedicineSupplier.find_by(id: params[:supplier_id], name: params[:supplier], station_id: @station.id)
		        if !@supplier_id.nil?
					    @supplier_id = @supplier_id.id
				    end
		        @script_id = MedicinePrescriptInternal.find_by(id: params[:internal_record_id], code: params[:internal_record_code], station_id: @station.id)
		        if !@script_id.nil?
					    @script_id = @script_id.id
		        end
		        @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		        if !@sample_id.nil?
					    @sample_id = @sample_id.id
		        end
		        @billin_id = MedicineBillIn.find_by(id: params[:bill_in_id], billcode: params[:bill_in_code], station_id: @station.id)
		        if !@billin_id.nil?
				      @billin_id = @billin_id.id
		        end
            if @supplier.update(typerecord: params[:typerecord], sample_id: @sample_id, supplier_id: @supplier_id, name: params[:name], noid: params[:noid], signid: params[:signid], amount: params[:amount], expire: params[:expire], supplier: params[:supplier], remark: params[:remark], internal_record_id: @script_id, bill_in_id: @billin_id, internal_record_code: params[:internal_record_code], bill_in_code: params[:bill_in_code])
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
			    @supplier = MedicineStockRecord.find(params[:id])
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
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
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
        head :no_content
      end
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
          start = MedicineStockRecord.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:name)
          @supplier = MedicineStockRecord.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:noid)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:supplier)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("supplier LIKE ? and station_id = ?" , "%#{params[:supplier]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:bill_in_code)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("bill_in_code LIKE ? and station_id = ?" , "%#{params[:bill_in_code]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:internal_record_code)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("internal_record_code LIKE ? and station_id = ?" , "%#{params[:internal_record_code]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:amount)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("amount = ? and station_id = ?" , params[:amount], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:expire)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("expire = ? and station_id = ?" , params[:expire], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:typerecord)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("typerecord = ? and station_id = ?" , params[:typerecord], @station.id)
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
          start = MedicineStockRecord.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:name)
          @supplier = MedicineStockRecord.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:noid)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:supplier)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("supplier LIKE ? and station_id = ?" , "%#{params[:supplier]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:bill_in_code)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("bill_in_code LIKE ? and station_id = ?" , "%#{params[:bill_in_code]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:internal_record_code)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("internal_record_code LIKE ? and station_id = ?" , "%#{params[:internal_record_code]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:amount)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("amount = ? and station_id = ?" , params[:amount], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:expire)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("expire = ? and station_id = ?" , params[:expire], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:typerecord)
				  @supplier = MedicineStockRecord.where(created_at: start..fin).where("typerecord = ? and station_id = ?" , params[:typerecord], @station.id)
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
