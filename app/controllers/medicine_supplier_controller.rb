class MedicineSupplierController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy]
  
  def list
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = MedicineSupplier.where(station_id: @station.id)
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
      redirect_to root_path
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
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:noid)
          @supplier = MedicineSupplier.where("noid LIKE ?" , "%#{params[:noid]}%").group(:noid).limit(3)
			    render json:@supplier
        end
        if params.has_key?(:contactname)
				  @supplier = MedicineSupplier.where("contactname LIKE ?" , "%#{params[:contactname]}%").group(:contactname).limit(3)
			    render json:@supplier
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
