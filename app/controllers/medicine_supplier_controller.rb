class MedicineSupplierController < ApplicationController
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
          @data[0] = MedicineSupplier.where(station_id: @station.id, created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicineSupplier.where(station_id: @station.id, created_at: start..fin)
        else
          @data[0] = MedicineSupplier.where(station_id: @station.id)
        end
			  render json: @data
		  else
        redirect_to root_path
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
          @data[0] = MedicineSupplier.where(station_id: @station.id, created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = MedicineSupplier.where(station_id: @station.id, created_at: start..fin)
        else
          @data[0] = MedicineSupplier.where(station_id: @station.id)
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
		    @supplier = MedicineSupplier.new(station_id: @station.id, name: params[:name], contactname: params[:contactname], address1: params[:address1], address2: params[:address2], address3: params[:address3], spnumber: params[:spnumber], pnumber: params[:pnumber], noid: params[:noid], email: params[:email], facebook: params[:facebook], twitter: params[:twitter], fax: params[:fax], taxcode: params[:taxcode])
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
		    @supplier = MedicineSupplier.new(station_id: @station.id, name: params[:name], contactname: params[:contactname], address1: params[:address1], address2: params[:address2], address3: params[:address3], spnumber: params[:spnumber], pnumber: params[:pnumber], noid: params[:noid], email: params[:email], facebook: params[:facebook], twitter: params[:twitter], fax: params[:fax], taxcode: params[:taxcode])
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
          @supplier = MedicineSupplier.find(params[:id])
			    if @supplier.station_id == @station.id
            if @supplier.update(name: params[:name], contactname: params[:contactname], address1: params[:address1], address2: params[:address2], address3: params[:address3], spnumber: params[:spnumber], pnumber: params[:pnumber], noid: params[:noid], email: params[:email], facebook: params[:facebook], twitter: params[:twitter], fax: params[:fax], taxcode: params[:taxcode])
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
          @supplier = MedicineSupplier.find(params[:id])
			    if @supplier.station_id == @station.id
            if @supplier.update(name: params[:name], contactname: params[:contactname], address1: params[:address1], address2: params[:address2], address3: params[:address3], spnumber: params[:spnumber], pnumber: params[:pnumber], noid: params[:noid], email: params[:email], facebook: params[:facebook], twitter: params[:twitter], fax: params[:fax], taxcode: params[:taxcode])
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

  def search
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
        if params.has_key?(:noid)
          @supplier = MedicineSupplier.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).limit(3)
			    render json:@supplier
        elsif params.has_key?(:name)
				  @supplier = MedicineSupplier.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id).group(:name).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:contactname)
				  @supplier = MedicineSupplier.where("contactname LIKE ? and station_id = ?" , "%#{params[:contactname]}%", @station.id).group(:contactname).limit(3)
			    render json:@supplier
				elsif params.has_key?(:spnumber)
				  @supplier = MedicineSupplier.where("spnumber LIKE ? and station_id = ?" , "%#{params[:spnumber]}%", @station.id).group(:spnumber).limit(3)
			    render json:@supplier
				elsif params.has_key?(:pnumber)
				  @supplier = MedicineSupplier.where("pnumber LIKE ? and station_id = ?" , "%#{params[:pnumber]}%", @station.id).group(:pnumber).limit(3)
			    render json:@supplier
				elsif params.has_key?(:address1)
				  @supplier = MedicineSupplier.where("address1 LIKE ? and station_id = ?" , "%#{params[:address1]}%", @station.id).group(:address1).limit(3)
			    render json:@supplier
				elsif params.has_key?(:address2)
				  @supplier = MedicineSupplier.where("address2 LIKE ? and station_id = ?" , "%#{params[:address2]}%", @station.id).group(:address2).limit(3)
			    render json:@supplier
				elsif params.has_key?(:address3)
				  @supplier = MedicineSupplier.where("address3 LIKE ? and station_id = ?" , "%#{params[:address3]}%", @station.id).group(:address3).limit(3)
			    render json:@supplier
				elsif params.has_key?(:email)
				  @supplier = MedicineSupplier.where("email LIKE ? and station_id = ?" , "%#{params[:email]}%", @station.id).group(:email).limit(3)
			    render json:@supplier
				elsif params.has_key?(:facebook)
				  @supplier = MedicineSupplier.where("facebook LIKE ? and station_id = ?" , "%#{params[:facebook]}%", @station.id).group(:facebook).limit(3)
			    render json:@supplier
				elsif params.has_key?(:twitter)
				  @supplier = MedicineSupplier.where("twitter LIKE ? and station_id = ?" , "%#{params[:twitter]}%", @station.id).group(:twitter).limit(3)
			    render json:@supplier
				elsif params.has_key?(:fax)
				  @supplier = MedicineSupplier.where("fax LIKE ? and station_id = ?" , "%#{params[:fax]}%", @station.id).group(:fax).limit(3)
			    render json:@supplier
				elsif params.has_key?(:taxcode)
				  @supplier = MedicineSupplier.where("taxcode LIKE ? and station_id = ?" , "%#{params[:taxcode]}%", @station.id).group(:taxcode).limit(3)
			    render json:@supplier
				end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:noid)
          @supplier = MedicineSupplier.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).limit(3)
			    render json:@supplier
        elsif params.has_key?(:name)
				  @supplier = MedicineSupplier.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id).group(:name).limit(3)
			    render json:@supplier
			  elsif params.has_key?(:contactname)
				  @supplier = MedicineSupplier.where("contactname LIKE ? and station_id = ?" , "%#{params[:contactname]}%", @station.id).group(:contactname).limit(3)
			    render json:@supplier
				elsif params.has_key?(:spnumber)
				  @supplier = MedicineSupplier.where("spnumber LIKE ? and station_id = ?" , "%#{params[:spnumber]}%", @station.id).group(:spnumber).limit(3)
			    render json:@supplier
				elsif params.has_key?(:pnumber)
				  @supplier = MedicineSupplier.where("pnumber LIKE ? and station_id = ?" , "%#{params[:pnumber]}%", @station.id).group(:pnumber).limit(3)
			    render json:@supplier
				elsif params.has_key?(:address1)
				  @supplier = MedicineSupplier.where("address1 LIKE ? and station_id = ?" , "%#{params[:address1]}%", @station.id).group(:address1).limit(3)
			    render json:@supplier
				elsif params.has_key?(:address2)
				  @supplier = MedicineSupplier.where("address2 LIKE ? and station_id = ?" , "%#{params[:address2]}%", @station.id).group(:address2).limit(3)
			    render json:@supplier
				elsif params.has_key?(:address3)
				  @supplier = MedicineSupplier.where("address3 LIKE ? and station_id = ?" , "%#{params[:address3]}%", @station.id).group(:address3).limit(3)
			    render json:@supplier
				elsif params.has_key?(:email)
				  @supplier = MedicineSupplier.where("email LIKE ? and station_id = ?" , "%#{params[:email]}%", @station.id).group(:email).limit(3)
			    render json:@supplier
				elsif params.has_key?(:facebook)
				  @supplier = MedicineSupplier.where("facebook LIKE ? and station_id = ?" , "%#{params[:facebook]}%", @station.id).group(:facebook).limit(3)
			    render json:@supplier
				elsif params.has_key?(:twitter)
				  @supplier = MedicineSupplier.where("twitter LIKE ? and station_id = ?" , "%#{params[:twitter]}%", @station.id).group(:twitter).limit(3)
			    render json:@supplier
				elsif params.has_key?(:fax)
				  @supplier = MedicineSupplier.where("fax LIKE ? and station_id = ?" , "%#{params[:fax]}%", @station.id).group(:fax).limit(3)
			    render json:@supplier
				elsif params.has_key?(:taxcode)
				  @supplier = MedicineSupplier.where("taxcode LIKE ? and station_id = ?" , "%#{params[:taxcode]}%", @station.id).group(:taxcode).limit(3)
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
          start = MedicineSupplier.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:noid)
          @supplier = MedicineSupplier.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:name)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:contactname)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("contactname LIKE ? and station_id = ?" , "%#{params[:contactname]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:spnumber)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("spnumber LIKE ? and station_id = ?" , "%#{params[:spnumber]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:pnumber)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("pnumber LIKE ? and station_id = ?" , "%#{params[:pnumber]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:address1)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("address1 LIKE ? and station_id = ?" , "%#{params[:address1]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:address2)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("address2 LIKE ? and station_id = ?" , "%#{params[:address2]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:address3)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("address3 LIKE ? and station_id = ?" , "%#{params[:address3]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:email)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("email LIKE ? and station_id = ?" , "%#{params[:email]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:facebook)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("facebook LIKE ? and station_id = ?" , "%#{params[:facebook]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:twitter)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("twitter LIKE ? and station_id = ?" , "%#{params[:twitter]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:fax)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("fax LIKE ? and station_id = ?" , "%#{params[:fax]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:taxcode)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("taxcode LIKE ? and station_id = ?" , "%#{params[:taxcode]}%", @station.id)
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
          start = MedicineSupplier.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:noid)
          @supplier = MedicineSupplier.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:name)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:contactname)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("contactname LIKE ? and station_id = ?" , "%#{params[:contactname]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:spnumber)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("spnumber LIKE ? and station_id = ?" , "%#{params[:spnumber]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:pnumber)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("pnumber LIKE ? and station_id = ?" , "%#{params[:pnumber]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:address1)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("address1 LIKE ? and station_id = ?" , "%#{params[:address1]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:address2)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("address2 LIKE ? and station_id = ?" , "%#{params[:address2]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:address3)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("address3 LIKE ? and station_id = ?" , "%#{params[:address3]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:email)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("email LIKE ? and station_id = ?" , "%#{params[:email]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:facebook)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where(created_at: start..fin).where("facebook LIKE ? and station_id = ?" , "%#{params[:facebook]}%", @station.id)
			    render json:@supplie
				elsif params.has_key?(:twitter)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("twitter LIKE ? and station_id = ?" , "%#{params[:twitter]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:fax)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("fax LIKE ? and station_id = ?" , "%#{params[:fax]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:taxcode)
				  @supplier = MedicineSupplier.where(created_at: start..fin).where("taxcode LIKE ? and station_id = ?" , "%#{params[:taxcode]}%", @station.id)
			    render json:@supplier
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
			    @supplier = MedicineSupplier.find(params[:id])
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
			    @supplier = MedicineSupplier.find(params[:id])
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
