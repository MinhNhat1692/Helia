class MedicineBillInController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy, :search, :find]
  
  def list
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = MedicineBillIn.where(station_id: @station.id)
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
		    @supplier = MedicineBillIn.new(station_id: @station.id, billcode: params[:billcode], dayin: params[:dayin], supplier: params[:supplier], daybook: params[:daybook], pmethod: params[:pmethod], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout], remark: params[:remark], status: params[:status])
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
          @supplier = MedicineBillIn.find(params[:id])
			    if @supplier.station_id == @station.id
            if @supplier.update(billcode: params[:billcode], dayin: params[:dayin], supplier: params[:supplier], daybook: params[:daybook], pmethod: params[:pmethod], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout], remark: params[:remark], status: params[:status])
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
			    @supplier = MedicineBillIn.find(params[:id])
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
        if params.has_key?(:billcode)
          @supplier = MedicineBillIn.where("billcode LIKE ? and station_id = ?" , "%#{params[:billcode]}%", @station.id).group(:billcode).limit(3)
			    render json:@supplier
        elsif params.has_key?(:supplier)
				  @supplier = MedicineBillIn.where("supplier LIKE ? and station_id = ?" , "%#{params[:supplier]}%", @station.id).group(:supplier).limit(3)
			    render json:@supplier
				elsif params.has_key?(:remark)
				  @supplier = MedicineBillIn.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id).group(:remark).limit(3)
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
        if params.has_key?(:billcode)
          @supplier = MedicineBillIn.where("billcode LIKE ? and station_id = ?" , "%#{params[:billcode]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:dayin)
				  @supplier = MedicineBillIn.where("dayin = ? and station_id = ?" , params[:dayin], @station.id)
			    render json:@supplier
        elsif params.has_key?(:supplier)
				  @supplier = MedicineBillIn.where("supplier LIKE ? and station_id = ?" , "%#{params[:supplier]}%", @station.id)
			    render json:@supplier
				elsif params.has_key?(:daybook)
				  @supplier = MedicineBillIn.where("daybook = ? and station_id = ?" , params[:daybook], @station.id)
			    render json:@supplier
				elsif params.has_key?(:pmethod)
				  @supplier = MedicineBillIn.where("pmethod = ? and station_id = ?" , params[:pmethod], @station.id)
			    render json:@supplier
				elsif params.has_key?(:tpayment)
				  @supplier = MedicineBillIn.where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:discount)
				  @supplier = MedicineBillIn.where("discount = ? and station_id = ?" , params[:discount], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:tpayout)
				  @supplier = MedicineBillIn.where("tpayout = ? and station_id = ?" , params[:tpayout], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:status)
				  @supplier = MedicineBillIn.where("status = ? and station_id = ?" , params[:status], @station.id)
			    render json:@supplier
				elsif params.has_key?(:remark)
				  @supplier = MedicineBillIn.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
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