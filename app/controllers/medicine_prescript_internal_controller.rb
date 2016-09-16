class MedicinePrescriptInternalController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy, :search, :find]
  
  def list
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  @data = []
			  @data[0] = MedicinePrescriptInternal.where(station_id: @station.id)
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
		    @customer_id = nil
		    @employee_id = nil
		    @preparer_id = nil
		    if params.has_key?(:customer_id) 
		      @customerrecord = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		      if @custommerrecord != nil
            @customer_id = @custommerrecord.id
          end
		    end
		    if params.has_key?(:employee_id)
		      @employee = Employee.find_by(id: params[:employee_id], ename: params[:ename], station_id: @station.id)
		      if @employee != nil
            @employee_id = @employee.id
          end
		    end
		    if params.has_key?(:preparer_id)
		      @preparer = Employee.find_by(id: params[:preparer_id], ename: params[:preparer], station_id: @station.id)
		      if @preparer != nil
            @preparer_id = @preparer.id
          end
		    end
		    @supplier = MedicinePrescriptInternal.new(station_id: @station.id, code: params[:code], customer_id: @customer_id, cname: params[:cname], employee_id: @employee_id, ename: params[:ename], result_id: params[:result_id], number_id: params[:number_id], date: params[:date], remark: params[:remark], preparer: params[:preparer], preparer_id: @preparer_id, payer: params[:payer], tpayment: params[:tpayment], discount: params[:discount], tpayout: params[:tpayout], pmethod: params[:pmethod])
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
          @supplier = MedicinePrescriptInternal.find(params[:id])
			    if @supplier.station_id == @station.id
            @customer_id = nil
		        @employee_id = nil
		        @preparer_id = nil
		        if params.has_key?(:customer_id) 
		          @customerrecord = CustomerRecord.find_by(id: params[:customer_id], cname: params[:cname], station_id: @station.id)
		          if @custommerrecord != nil
                @customer_id = @custommerrecord.id
              end
		        end
		        if params.has_key?(:employee_id)
		          @employee = Employee.find_by(id: params[:employee_id], ename: params[:ename], station_id: @station.id)
		          if @employee != nil
                @employee_id = @employee.id
              end
		        end
		        if params.has_key?(:preparer_id)
		          @preparer = Employee.find_by(id: params[:preparer_id], ename: params[:preparer], station_id: @station.id)
		          if @preparer != nil
                @preparer_id = @preparer.id
              end
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
      redirect_to root_path
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
      redirect_to root_path
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
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:code)
          @supplier = MedicinePrescriptInternal.where("code LIKE ? and station_id = ?" , "%#{params[:code]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:cname)
				  @supplier = MedicinePrescriptInternal.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:ename)
				  @supplier = MedicinePrescriptInternal.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:number_id)
				  @supplier = MedicinePrescriptInternal.where("number_id LIKE ? and station_id = ?" , "%#{params[:number_id]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:remark)
				  @supplier = MedicinePrescriptInternal.where("remark LIKE ? and station_id = ?" , "%#{params[:remark]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:preparer)
				  @supplier = MedicinePrescriptInternal.where("preparer LIKE ? and station_id = ?" , "%#{params[:preparer]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:payer)
				  @supplier = MedicinePrescriptInternal.where("payer LIKE ? and station_id = ?" , "%#{params[:payer]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:result_id)
				  @supplier = MedicinePrescriptInternal.where("result_id = ? and station_id = ?" , params[:result_id], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:date)
				  @supplier = MedicinePrescriptInternal.where("date = ? and station_id = ?" , params[:date], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:tpayment)
				  @supplier = MedicinePrescriptInternal.where("tpayment = ? and station_id = ?" , params[:tpayment], @station.id)
			    render json:@supplier
			   elsif params.has_key?(:discount)
				  @supplier = MedicinePrescriptInternal.where("discount = ? and station_id = ?" , params[:discount], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:tpayout)
				  @supplier = MedicinePrescriptInternal.where("tpayout = ? and station_id = ?" , params[:tpayout], @station.id)
			    render json:@supplier
			  elsif params.has_key?(:pmethod)
				  @supplier = MedicinePrescriptInternal.where("pmethod = ? and station_id = ?" , params[:pmethod], @station.id)
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
