class MedicineSampleController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy, :search, :find]
  
  def list
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = MedicineSample.where(station_id: @station.id)
			  @data[1] = MedicineGroup.all
			  @data[2] = MedicineType.all
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
		    @supplier = MedicineSample.new(station_id: @station.id, name: params[:name], typemedicine: params[:typemedicine], groupmedicine: params[:groupmedicine], company: params[:company], price: params[:price], weight: params[:weight], remark: params[:remark], noid: params[:noid], expire: params[:expire])
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
          @supplier = MedicineSample.find(params[:id])
			    if @supplier.station_id == @station.id
            if @supplier.update(name: params[:name], typemedicine: params[:typemedicine], groupmedicine: params[:groupmedicine], company: params[:company], price: params[:price], weight: params[:weight], remark: params[:remark], noid: params[:noid], expire: params[:expire])
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
      redirect_to root_path
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
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:noid)
          @supplier = MedicineSample.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:name)
				  @supplier = MedicineSample.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:company)
				  @supplier = MedicineSample.where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:typemedicine)
				  @supplier = MedicineSample.where("typemedicine = ? and station_id = ?" , params[:typemedicine], @station.id)
			    render json:@supplier
				elsif params.has_key?(:groupmedicine)
				  @supplier = MedicineSample.where("groupmedicine = ? and station_id = ?" , params[:groupmedicine], @station.id)
			    render json:@supplier
				elsif params.has_key?(:price)
				  @supplier = MedicineSample.where("price = ? and station_id = ?" , params[:price], @station.id)
			    render json:@supplier
				elsif params.has_key?(:weight)
				  @supplier = MedicineSample.where("weight = ? and station_id = ?" , params[:weight], @station.id)
			    render json:@supplier
				elsif params.has_key?(:remark)
				  @supplier = MedicineSample.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:expire)
				  @supplier = MedicineSample.where("expire = ? and station_id = ?" , params[:expire], @station.id)
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
