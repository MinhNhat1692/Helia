class MedicineSampleController < ApplicationController
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
          @data[0] = MedicineSample.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicineSample.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicineSample.where(station_id: @station.id)
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
          @data[0] = MedicineSample.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicineSample.where(station_id: @station.id, created_at: start..fin)
          @data[1] = MedicineGroup.where(created_at: start..fin)
          @data[2] = MedicineType.where(created_at: start..fin)
        else
          @data[0] = MedicineSample.where(station_id: @station.id)
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
		    @company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		    if !@company_id.nil?
					@company_id = @company_id.id
		    end
		    @supplier = MedicineSample.new(station_id: @station.id, company_id: @company_id, name: params[:name], typemedicine: params[:typemedicine], groupmedicine: params[:groupmedicine], company: params[:company], price: params[:price], weight: params[:weight], remark: params[:remark], noid: params[:noid], expire: params[:expire])
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
		    @company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		    if !@company_id.nil?
					@company_id = @company_id.id
		    end
		    @supplier = MedicineSample.new(station_id: @station.id, company_id: @company_id, name: params[:name], typemedicine: params[:typemedicine], groupmedicine: params[:groupmedicine], company: params[:company], price: params[:price], weight: params[:weight], remark: params[:remark], noid: params[:noid], expire: params[:expire])
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
          @supplier = MedicineSample.find(params[:id])
			    if @supplier.station_id == @station.id
						@company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		        if !@company_id.nil?
					    @company_id = @company_id.id
		        end
            if @supplier.update(name: params[:name], company_id: @company_id, typemedicine: params[:typemedicine], groupmedicine: params[:groupmedicine], company: params[:company], price: params[:price], weight: params[:weight], remark: params[:remark], noid: params[:noid], expire: params[:expire])
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
          @supplier = MedicineSample.find(params[:id])
			    if @supplier.station_id == @station.id
						@company_id = MedicineCompany.find_by(id: params[:company_id], name: params[:company], station_id: @station.id)
		        if !@company_id.nil?
					    @company_id = @company_id.id
		        end
            if @supplier.update(name: params[:name], company_id: @company_id, typemedicine: params[:typemedicine], groupmedicine: params[:groupmedicine], company: params[:company], price: params[:price], weight: params[:weight], remark: params[:remark], noid: params[:noid], expire: params[:expire])
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
			    @supplier = MedicineSample.find(params[:id])
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
			    @supplier = MedicineSample.find(params[:id])
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
        if params.has_key?(:noid)
          @supplier = MedicineSample.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).limit(3)
			    render json:@supplier
        elsif params.has_key?(:name)
				  @supplier = MedicineSample.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id).group(:name).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineSample.where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id).group(:company).limit(3)
			    render json:@supplier
				elsif params.has_key?(:price)
				  @supplier = MedicineSample.where("price = ? and station_id = ?" , params[:price], @station.id).group(:price).limit(3)
			    render json:@supplier
				elsif params.has_key?(:weight)
				  @supplier = MedicineSample.where("weight = ? and station_id = ?" , params[:weight], @station.id).group(:weight).limit(3)
			    render json:@supplier
				elsif params.has_key?(:remark)
				  @supplier = MedicineSample.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
			    render json:@supplier
				elsif params.has_key?(:expire)
				  @supplier = MedicineSample.where("expire = ? and station_id = ?" , params[:expire], @station.id).group(:expire).limit(3)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:noid)
          @supplier = MedicineSample.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).limit(3)
			    render json:@supplier
        elsif params.has_key?(:name)
				  @supplier = MedicineSample.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id).group(:name).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineSample.where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id).group(:company).limit(3)
			    render json:@supplier
				elsif params.has_key?(:price)
				  @supplier = MedicineSample.where("price = ? and station_id = ?" , params[:price], @station.id).group(:price).limit(3)
			    render json:@supplier
				elsif params.has_key?(:weight)
				  @supplier = MedicineSample.where("weight = ? and station_id = ?" , params[:weight], @station.id).group(:weight).limit(3)
			    render json:@supplier
				elsif params.has_key?(:remark)
				  @supplier = MedicineSample.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
			    render json:@supplier
				elsif params.has_key?(:expire)
				  @supplier = MedicineSample.where("expire = ? and station_id = ?" , params[:expire], @station.id).group(:expire).limit(3)
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
          start = MedicineSample.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:noid)
          @supplier = MedicineSample.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:name)
				  @supplier = MedicineSample.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:name_sell)
				  @supplier = MedicineSample.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name_sell]}%", @station.id)
				  for sample in @supplier do
						@sellprice = MedicinePrice.where(sample_id: sample.id, station_id: sample.station_id).order(updated_at: :desc)
						if !@sellprice[0].nil?
							sample.price = @sellprice[0].price
						end
					end
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineSample.where(created_at: start..fin).where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:typemedicine)
				  @supplier = MedicineSample.where(created_at: start..fin).where("typemedicine = ? and station_id = ?" , params[:typemedicine], @station.id)
			    render json:@supplier
				elsif params.has_key?(:groupmedicine)
				  @supplier = MedicineSample.where(created_at: start..fin).where("groupmedicine = ? and station_id = ?" , params[:groupmedicine], @station.id)
			    render json:@supplier
				elsif params.has_key?(:price)
				  @supplier = MedicineSample.where(created_at: start..fin).where("price = ? and station_id = ?" , params[:price], @station.id)
			    render json:@supplier
				elsif params.has_key?(:weight)
				  @supplier = MedicineSample.where(created_at: start..fin).where("weight = ? and station_id = ?" , params[:weight], @station.id)
			    render json:@supplier
				elsif params.has_key?(:remark)
				  @supplier = MedicineSample.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:expire)
				  @supplier = MedicineSample.where(created_at: start..fin).where("expire = ? and station_id = ?" , params[:expire], @station.id)
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
          start = MedicineSample.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:noid)
          @supplier = MedicineSample.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:name)
				  @supplier = MedicineSample.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:name_sell)
				  @supplier = MedicineSample.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name_sell]}%", @station.id)
				  for sample in @supplier do
						@sellprice = MedicinePrice.where(sample_id: sample.id, station_id: sample.station_id).order(updated_at: :desc)
						if !@sellprice[0].nil?
							sample.price = @sellprice[0].price
						end
					end
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineSample.where(created_at: start..fin).where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:typemedicine)
				  @supplier = MedicineSample.where(created_at: start..fin).where("typemedicine = ? and station_id = ?" , params[:typemedicine], @station.id)
			    render json:@supplier
				elsif params.has_key?(:groupmedicine)
				  @supplier = MedicineSample.where(created_at: start..fin).where("groupmedicine = ? and station_id = ?" , params[:groupmedicine], @station.id)
			    render json:@supplier
				elsif params.has_key?(:price)
				  @supplier = MedicineSample.where(created_at: start..fin).where("price = ? and station_id = ?" , params[:price], @station.id)
			    render json:@supplier
				elsif params.has_key?(:weight)
				  @supplier = MedicineSample.where(created_at: start..fin).where("weight = ? and station_id = ?" , params[:weight], @station.id)
			    render json:@supplier
				elsif params.has_key?(:remark)
				  @supplier = MedicineSample.where(created_at: start..fin).where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:expire)
				  @supplier = MedicineSample.where(created_at: start..fin).where("expire = ? and station_id = ?" , params[:expire], @station.id)
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
