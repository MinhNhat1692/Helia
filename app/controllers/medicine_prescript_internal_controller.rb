class MedicinePrescriptInternalController < ApplicationController
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
          @data[0] = MedicinePrescriptInternal.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicinePrescriptInternal.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicinePrescriptInternal.where(station_id: @station.id)
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
          @data[0] = MedicinePrescriptInternal.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicinePrescriptInternal.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicinePrescriptInternal.where(station_id: @station.id)
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
      if current_user.check_permission params[:id_station], 2, 1
			  @station = Station.find params[:id_station]
		    @customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		    if !@customer_id.nil?
					@customer_id = @customer_id.id
				end
		    @employee_id = Employee.find_by(id: params[:employee_id], ename: params[:ename], station_id: @station.id)
		    if !@employee_id.nil?
					@employee_id = @employee_id.id
		    end
		    @preparer_id = Employee.find_by(id: params[:preparer_id], ename: params[:preparer], station_id: @station.id)
		    if !@preparer_id.nil?
					@preparer_id = @preparer_id.id
				end
		    @supplier = MedicinePrescriptInternal.new(station_id: @station.id, code: params[:code], customer_id: @customer_id,
                                                  cname: params[:cname], employee_id: @employee_id, ename: params[:ename],
                                                  result_id: params[:result_id], number_id: params[:number_id], date: params[:date],
                                                  remark: params[:remark], preparer: params[:preparer], preparer_id: @preparer_id,
                                                  payer: params[:payer], tpayment: params[:tpayment], discount: params[:discount],
                                                  tpayout: params[:tpayout], pmethod: params[:pmethod])
				if @supplier.save
					for internal_record in JSON.parse(params[:list_internal_record]) do
            @sample_id = MedicineSample.find_by(id: internal_record["sample_id"], name: internal_record["name"], station_id: @station.id)
		        if !@sample_id.nil?
				      @sample_id = @sample_id.id
		        end
            @company_id = MedicineCompany.find_by(id: internal_record["company_id"], name: internal_record["company"], station_id: @station.id)
		        if !@company_id.nil?
				      @company_id = @company_id.id
		        end
            med_stock = MedicineStockRecord.find_by(station_id: @station.id, noid: internal_record["noid"], 
              signid: internal_record["signid"], name: internal_record["name"])
            @internalrecord = MedicineInternalRecord.new(station_id: @station.id, cname: @supplier.cname,
                                                         customer_id: @supplier.customer_id, script_id: @supplier.id,
                                                         script_code: @supplier.code, name: internal_record["name"],
                                                         sample_id: @sample_id, company: internal_record["company"],
                                                         company_id: @company_id, amount: internal_record["amount"],
                                                         remark: internal_record["remark"], price: internal_record["price"],
                                                         tpayment: internal_record["tpayment"], status: internal_record["status"],
                                                         noid: internal_record["noid"], signid: internal_record["signid"])
            @internalrecord.save
            if @supplier.discount.present?
              discount = @supplier.discount * (@internalrecord.tpayment.to_f / @supplier.tpayment)
              @internalrecord.update(discount: discount.to_i)
            end
            case @internalrecord.status
            when 1
              type = 2
            else
              type = 3
            end
            if med_stock
              MedicineStockRecord.create(station_id: @station.id, typerecord: 2, name: internal_record["name"], amount: internal_record["amount"],
                internal_record_id: @internalrecord.id, internal_record_code: @internalrecord.script_code, remark: internal_record["remark"],
                sample_id: @sample_id, noid: internal_record["noid"], signid: internal_record["signid"], supplier: med_stock.supplier, supplier_id: med_stock.supplier_id, expire: med_stock.expire)
            else
              MedicineStockRecord.create(station_id: @station.id, typerecord: 2, name: internal_record["name"], amount: internal_record["amount"],
                internal_record_id: @internalrecord.id, internal_record_code: @internalrecord.script_code, remark: internal_record["remark"],
                sample_id: @sample_id, noid: internal_record["noid"], signid: internal_record["signid"])
            end
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
		    @preparer_id = Employee.find_by(id: params[:preparer_id], ename: params[:preparer], station_id: @station.id)
		    if !@preparer_id.nil?
					@preparer_id = @preparer_id.id
				end
		    @supplier = MedicinePrescriptInternal.new(station_id: @station.id, code: params[:code], customer_id: @customer_id,
                                                  cname: params[:cname], employee_id: @employee_id, ename: params[:ename],
                                                  result_id: params[:result_id], number_id: params[:number_id], date: params[:date],
                                                  remark: params[:remark], preparer: params[:preparer], preparer_id: @preparer_id,
                                                  payer: params[:payer], tpayment: params[:tpayment], discount: params[:discount],
                                                  tpayout: params[:tpayout], pmethod: params[:pmethod])
				if @supplier.save
					for internal_record in JSON.parse(params[:list_internal_record]) do
            @sample_id = MedicineSample.find_by(id: internal_record["sample_id"], name: internal_record["name"], station_id: @station.id)
		        if !@sample_id.nil?
				      @sample_id = @sample_id.id
		        end
            @company_id = MedicineCompany.find_by(id: internal_record["company_id"], name: internal_record["company"], station_id: @station.id)
		        if !@company_id.nil?
				      @company_id = @company_id.id
		        end
            med_stock = MedicineStockRecord.find_by(station_id: @station.id, noid: internal_record["noid"], 
              signid: internal_record["signid"], name: internal_record["name"])
            @internalrecord = MedicineInternalRecord.new(station_id: @station.id, cname: @supplier.cname,
                                                         customer_id: @supplier.customer_id, script_id: @supplier.id,
                                                         script_code: @supplier.code, name: internal_record["name"],
                                                         sample_id: @sample_id, company: internal_record["company"],
                                                         company_id: @company_id, amount: internal_record["amount"],
                                                         remark: internal_record["remark"], price: internal_record["price"],
                                                         tpayment: internal_record["tpayment"], status: internal_record["status"],
                                                         noid: internal_record["noid"], signid: internal_record["signid"])
            @internalrecord.save
            if @supplier.discount.present?
              discount = @supplier.discount * (@internalrecord.tpayment.to_f / @supplier.tpayment)
              @internalrecord.update(discount: discount.to_i)
            end
            case @internalrecord.status
            when 1
              type = 2
            else
              type = 3
            end
            if med_stock
              MedicineStockRecord.create(station_id: @station.id, typerecord: type, name: internal_record["name"], amount: internal_record["amount"],
                internal_record_id: @internalrecord.id, internal_record_code: @internalrecord.script_code, remark: internal_record["remark"],
                sample_id: @sample_id, noid: internal_record["noid"], signid: internal_record["signid"], supplier: med_stock.supplier, supplier_id: med_stock.supplier_id, expire: med_stock.expire)
            else
              MedicineStockRecord.create(station_id: @station.id, typerecord: type, name: internal_record["name"], amount: internal_record["amount"],
                internal_record_id: @internalrecord.id, internal_record_code: @internalrecord.script_code, remark: internal_record["remark"],
                sample_id: @sample_id, noid: internal_record["noid"], signid: internal_record["signid"])
            end
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
      if current_user.check_permission params[:id_station], 2, 2
        @station = Station.find params[:id_station]
        if params.has_key?(:id)
          @prescript = MedicinePrescriptInternal.find(params[:id])
			    if @prescript.station_id == @station.id
						if params.has_key?(:prep)
							#@preparer_id = Employee.find_by(id: params[:preparer_id], ename: params[:preparer], station_id: @station.id) - still need to add preparer id here
							#if !@preparer_id.nil?
							#	@preparer_id = @preparer_id.id
							#end
							if @prescript.update(remark: params[:remark], payer: params[:payer], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout], pmethod: params[:pmethod])
								for internal_record in JSON.parse(params[:list_internal_record]) do
									puts internal_record
									@internalRecord = MedicineInternalRecord.find_by(id: internal_record["id"])
									if @internalRecord.station_id == @station.id and @internalRecord.script_id == @prescript.id
										@internalRecord.update(noid: internal_record["noid"], signid: internal_record["signid"], status: internal_record["status"], remark: internal_record["remark"], amount: internal_record["amount"], price: internal_record["price"], tpayment: internal_record["tpayment"])
										if @prescript.discount.present?
											discount = @prescript.discount * (@internalRecord[:tpayment].to_f / @prescript.tpayment)
											@internalRecord.update(discount: discount.to_i)
										end
									end
								end
								render json: @prescript
							else
								render json: @prescript.errors, status: :unprocessable_entity
							end
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
          @supplier = MedicinePrescriptInternal.find(params[:id])
			    if @supplier.station_id == @station.id
            @customer_id = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		        if !@customer_id.nil?
					    @customer_id = @customer_id.id
				    end
		        @employee_id = Employee.find_by(id: params[:employee_id], ename: params[:ename], station_id: @station.id)
		        if !@employee_id.nil?
					    @employee_id = @employee_id.id
		        end
		        @preparer_id = Employee.find_by(id: params[:preparer_id], ename: params[:preparer], station_id: @station.id)
		        if !@preparer_id.nil?
					    @preparer_id = @preparer_id.id
				    end
		        if @supplier.update(code: params[:code], customer_id: @customer_id, cname: params[:cname], employee_id: @employee_id, ename: params[:ename], result_id: params[:result_id], number_id: params[:number_id], date: params[:date], remark: params[:remark], preparer: params[:preparer], preparer_id: @preparer_id, payer: params[:payer], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout], pmethod: params[:pmethod])
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
			    @supplier = MedicinePrescriptInternal.find(params[:id])
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
			    @supplier = MedicinePrescriptInternal.find(params[:id])
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
        if params.has_key?(:code)
          @supplier = MedicinePrescriptInternal.where("code LIKE ? and station_id = ?" , "%#{params[:code]}%", @station.id).group(:code).limit(3)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicinePrescriptInternal.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:ename)
				  @supplier = MedicinePrescriptInternal.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id).group(:ename).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:number_id)
				  @supplier = MedicinePrescriptInternal.where("number_id LIKE ? and station_id = ?" , "%#{params[:number_id]}%", @station.id).group(:number_id).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicinePrescriptInternal.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:preparer)
				  @supplier = MedicinePrescriptInternal.where("preparer LIKE ? and station_id = ?" , "%#{params[:preparer]}%", @station.id).group(:preparer).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:payer)
				  @supplier = MedicinePrescriptInternal.where("payer LIKE ? and station_id = ?" , "%#{params[:payer]}%", @station.id).group(:payer).limit(3)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:code)
          @supplier = MedicinePrescriptInternal.where("code LIKE ? and station_id = ?" , "%#{params[:code]}%", @station.id).group(:code).limit(3)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicinePrescriptInternal.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:ename)
				  @supplier = MedicinePrescriptInternal.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id).group(:ename).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:number_id)
				  @supplier = MedicinePrescriptInternal.where("number_id LIKE ? and station_id = ?" , "%#{params[:number_id]}%", @station.id).group(:number_id).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicinePrescriptInternal.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:preparer)
				  @supplier = MedicinePrescriptInternal.where("preparer LIKE ? and station_id = ?" , "%#{params[:preparer]}%", @station.id).group(:preparer).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:payer)
				  @supplier = MedicinePrescriptInternal.where("payer LIKE ? and station_id = ?" , "%#{params[:payer]}%", @station.id).group(:payer).limit(3)
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
          start = MedicinePrescriptInternal.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:code)
          @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("code LIKE ? and station_id = ?" , "%#{params[:code]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:ename)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:number_id)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("number_id LIKE ? and station_id = ?" , "%#{params[:number_id]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:preparer)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("preparer LIKE ? and station_id = ?" , "%#{params[:preparer]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:payer)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("payer LIKE ? and station_id = ?" , "%#{params[:payer]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:result_id)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("result_id = ? and station_id = ?" , params[:result_id], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:date)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("date = ? and station_id = ?" , params[:date], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:tpayment)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id)
			    render json:@supplier
			   elsif params.has_key?(:discount)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("discount = ? and station_id = ?" , params[:discount], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:tpayout)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("tpayout = ? and station_id = ?" , params[:tpayout], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:pmethod)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("pmethod = ? and station_id = ?" , params[:pmethod], @station.id)
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
          start = MedicinePrescriptInternal.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:code)
          @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("code LIKE ? and station_id = ?" , "%#{params[:code]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:ename)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:number_id)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("number_id LIKE ? and station_id = ?" , "%#{params[:number_id]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:preparer)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("preparer LIKE ? and station_id = ?" , "%#{params[:preparer]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:payer)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("payer LIKE ? and station_id = ?" , "%#{params[:payer]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:result_id)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("result_id = ? and station_id = ?" , params[:result_id], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:date)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("date = ? and station_id = ?" , params[:date], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:tpayment)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id)
			    render json:@supplier
			   elsif params.has_key?(:discount)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("discount = ? and station_id = ?" , params[:discount], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:tpayout)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("tpayout = ? and station_id = ?" , params[:tpayout], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:pmethod)
				  @supplier = MedicinePrescriptInternal.where(created_at: start..fin).where("pmethod = ? and station_id = ?" , params[:pmethod], @station.id)
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
