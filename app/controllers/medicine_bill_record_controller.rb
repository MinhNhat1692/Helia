class MedicineBillRecordController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy, :search, :find]
  
  def list
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = MedicineBillRecord.where(station_id: @station.id)
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
			  @billin = MedicineBillIn.find_by(billcode: params[:billcode], station_id: @station.id)
			  if @billin != nil
          @supplier = MedicineBillRecord.new(station_id: @station.id, bill_id: @billin.id, name: params[:name], company: params[:company], noid: params[:noid], signid: params[:signid], expire: params[:expire], pmethod: params[:pmethod], qty: params[:qty], taxrate: params[:taxrate], price: params[:price], remark: params[:remark])
          if @supplier.save
            render json: @supplier
          else
          	render json: @supplier.errors, status: :unprocessable_entity
          end
        else
          @supplier = MedicineBillRecord.new(station_id: @station.id, name: params[:name], company: params[:company], noid: params[:noid], signid: params[:signid], expire: params[:expire], pmethod: params[:pmethod], qty: params[:qty], taxrate: params[:taxrate], price: params[:price], remark: params[:remark])
          if @supplier.save
            render json: @supplier
          else
          	render json: @supplier.errors, status: :unprocessable_entity
          end
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
          @supplier = MedicineBillRecord.find(params[:id])
			    if @supplier.station_id == @station.id
            if @supplier.update(name: params[:name], company: params[:company], noid: params[:noid], signid: params[:signid], expire: params[:expire], pmethod: params[:pmethod], qty: params[:qty], taxrate: params[:taxrate], price: params[:price], remark: params[:remark])
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
      redirect_to root_path
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
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:name)
          @supplier = MedicineBillRecord.where("name LIKE ? and station_id = ?" , "%#{params[:name]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:company)
				  @supplier = MedicineBillRecord.where("company LIKE ? and station_id = ?" , "%#{params[:company]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:noid)
				  @supplier = MedicineBillRecord.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:signid)
				  @supplier = MedicineBillRecord.where("signid LIKE ? and station_id = ?" , "%#{params[:signid]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:expire)
          @supplier = MedicineBillRecord.where("expire = ? and station_id = ?" , params[:expire], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:pmethod)
          @supplier = MedicineBillRecord.where("pmethod = ? and station_id = ?" , params[:pmethod], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:qty)
          @supplier = MedicineBillRecord.where("qty = ? and station_id = ?" , params[:qty], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:taxrate)
          @supplier = MedicineBillRecord.where("taxrate = ? and station_id = ?" , params[:taxrate], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:price)
          @supplier = MedicineBillRecord.where("price = ? and station_id = ?" , params[:price], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicineBillRecord.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
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
