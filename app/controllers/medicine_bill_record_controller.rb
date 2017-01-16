class MedicineBillRecordController < ApplicationController
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
          @data[0] = MedicineBillRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicineBillRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicineBillRecord.where(station_id: @station.id)
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
          @data[0] = MedicineBillRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicineBillRecord.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicineBillRecord.where(station_id: @station.id)
          @data[1] = MedicineGroup.all
          @data[2] = MedicineType.all
        end
			  render json: @data
		  else
        redirect_to root_path
      end
    end
  end
  
  def summary
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
        @data = []
        if params.has_key?(:date)
          if params.has_key?(:supplier) && params.has_key?(:supplier_id)
            n = params[:date].to_i
            start_date = n.days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
            end_date = Time.now.to_date + 1
            @data[0] = MedicineBillRecord.sum_payment start_date, end_date, params[:supplier], params[:supplier_id], @station.id
            render json: @data
          else
            redirect_to root_path
          end
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          if params.has_key?(:supplier) && params.has_key?(:supplier_id)
            start_date = params[:begin_date].to_date
            end_date = params[:end_date].to_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
            @data[0] = MedicineBillRecord.sum_payment start_date, end_date, params[:supplier], params[:supplier_id], @station.id
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
          if params.has_key?(:supplier) && params.has_key?(:supplier_id)
            n = params[:date].to_i
            start_date = n.days.ago.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
            end_date = Time.now.to_date + 1
            @data[0] = MedicineBillRecord.sum_payment start_date, end_date, params[:supplier], params[:supplier_id], @station.id
            render json: @data
          else
            redirect_to root_path
          end
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          if params.has_key?(:supplier) && params.has_key?(:supplier_id)
            start_date = params[:begin_date].to_date
            end_date = params[:end_date].to_date.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
            @data[0] = MedicineBillRecord.sum_payment start_date, end_date, params[:supplier], params[:supplier_id], @station.id
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
			  @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		    if !@sample_id.nil?
				  @sample_id = @sample_id.id
		    end
			  @company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		    if !@company_id.nil?
				  @company_id = @company_id.id
		    end
		    @billcode_id = MedicineBillIn.find_by(id: params[:billcode_id], billcode: params[:billcode], station_id: @station.id)
		    if !@billcode_id.nil?
				  @billcode_id = @billcode_id.id
		    end
			  @supplier = MedicineBillRecord.new(station_id: @station.id, billcode: params[:billcode], bill_id: @billcode_id, sample_id: @sample_id, name: params[:name], company_id: @company_id, company: params[:company], noid: params[:noid], signid: params[:signid], expire: params[:expire], pmethod: params[:pmethod], qty: params[:qty], taxrate: params[:taxrate], price: params[:price], remark: params[:remark])
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
			  @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		    if !@sample_id.nil?
				  @sample_id = @sample_id.id
		    end
			  @company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		    if !@company_id.nil?
				  @company_id = @company_id.id
		    end
		    @billcode_id = MedicineBillIn.find_by(id: params[:billcode_id], billcode: params[:billcode], station_id: @station.id)
		    if !@billcode_id.nil?
				  @billcode_id = @billcode_id.id
		    end
			  @supplier = MedicineBillRecord.new(station_id: @station.id, billcode: params[:billcode], bill_id: @billcode_id, sample_id: @sample_id, name: params[:name], company_id: @company_id, company: params[:company], noid: params[:noid], signid: params[:signid], expire: params[:expire], pmethod: params[:pmethod], qty: params[:qty], taxrate: params[:taxrate], price: params[:price], remark: params[:remark])
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
          @supplier = MedicineBillRecord.find(params[:id])
			    if @supplier.station_id == @station.id
            @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		        if !@sample_id.nil?
				      @sample_id = @sample_id.id
		        end
			      @company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		        if !@company_id.nil?
				      @company_id = @company_id.id
		        end
		        @billcode_id = MedicineBillIn.find_by(id: params[:billcode_id], billcode: params[:billcode], station_id: @station.id)
		        if !@billcode_id.nil?
				      @billcode_id = @billcode_id.id
		        end
            if @supplier.update(billcode: params[:billcode], bill_id: @billcode_id, sample_id: @sample_id, name: params[:name], company_id: @company_id, company: params[:company], noid: params[:noid], signid: params[:signid], expire: params[:expire], pmethod: params[:pmethod], qty: params[:qty], taxrate: params[:taxrate], price: params[:price], remark: params[:remark])
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
          @supplier = MedicineBillRecord.find(params[:id])
			    if @supplier.station_id == @station.id
            @sample_id = MedicineSample.find_by(id: params[:sample_id], name: params[:name], station_id: @station.id)
		        if !@sample_id.nil?
				      @sample_id = @sample_id.id
		        end
			      @company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		        if !@company_id.nil?
				      @company_id = @company_id.id
		        end
		        @billcode_id = MedicineBillIn.find_by(id: params[:billcode_id], billcode: params[:billcode], station_id: @station.id)
		        if !@billcode_id.nil?
				      @billcode_id = @billcode_id.id
		        end
            if @supplier.update(billcode: params[:billcode], bill_id: @billcode_id, sample_id: @sample_id, name: params[:name], company_id: @company_id, company: params[:company], noid: params[:noid], signid: params[:signid], expire: params[:expire], pmethod: params[:pmethod], qty: params[:qty], taxrate: params[:taxrate], price: params[:price], remark: params[:remark])
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
			    @supplier = MedicineBillRecord.find(params[:id])
			    if @supplier.station_id == @station.id
				    @supplier.destroy
				    head :no_content
			    end
			  end
		  else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  if params.has_key?(:id)
			    @supplier = MedicineBillRecord.find(params[:id])
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
          @supplier = MedicineBillRecord.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id).group(:name).limit(3)
			    render json:@supplier
        elsif params.has_key?(:company)
				  @supplier = MedicineBillRecord.where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id).group(:company).limit(3)
			    render json:@supplier
				elsif params.has_key?(:noid)
				  @supplier = MedicineBillRecord.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineBillRecord.where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id).group(:signid).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineBillRecord.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:name)
          @supplier = MedicineBillRecord.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id).group(:name).limit(3)
			    render json:@supplier
        elsif params.has_key?(:company)
				  @supplier = MedicineBillRecord.where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id).group(:company).limit(3)
			    render json:@supplier
				elsif params.has_key?(:noid)
				  @supplier = MedicineBillRecord.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineBillRecord.where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id).group(:signid).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineBillRecord.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
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
          start = MedicineBillRecord.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:name)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
          render json: @supplier
        elsif params.has_key?(:company)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id)
          render json: @supplier
        elsif params.has_key?(:noid)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
          render json: @supplier
        elsif params.has_key?(:signid)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id)
          render json: @supplier
        elsif params.has_key?(:expire)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("expire = ? and station_id = ?" , params[:expire], @station.id)
          render json: @supplier
        elsif params.has_key?(:pmethod)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("pmethod = ? and station_id = ?" , params[:pmethod], @station.id)
          render json: @supplier
        elsif params.has_key?(:qty)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("qty = ? and station_id = ?" , params[:qty], @station.id)
          render json: @supplier
        elsif params.has_key?(:taxrate)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("taxrate = ? and station_id = ?" , params[:taxrate], @station.id)
          render json: @supplier
        elsif params.has_key?(:price)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("price = ? and station_id = ?" , params[:price], @station.id)
          render json: @supplier
        elsif params.has_key?(:remark)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
          render json: @supplier
        elsif params.has_key?(:bill_id)
          @supplier = MedicineBillRecord.where("bill_id = ? and station_id = ?" , params[:bill_id], @station.id)
          render json: @supplier
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
          start = MedicineBillRecord.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:name)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:company)
				  @supplier = MedicineBillRecord.where(created_at: start..fin).where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:noid)
				  @supplier = MedicineBillRecord.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineBillRecord.where(created_at: start..fin).where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:expire)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("expire = ? and station_id = ?" , params[:expire], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:pmethod)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("pmethod = ? and station_id = ?" , params[:pmethod], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:qty)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("qty = ? and station_id = ?" , params[:qty], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:taxrate)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("taxrate = ? and station_id = ?" , params[:taxrate], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:price)
          @supplier = MedicineBillRecord.where(created_at: start..fin).where("price = ? and station_id = ?" , params[:price], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineBillRecord.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:bill_id)
				  @supplier = MedicineBillRecord.where("bill_id = ? and station_id = ?" , params[:bill_id], @station.id)
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
