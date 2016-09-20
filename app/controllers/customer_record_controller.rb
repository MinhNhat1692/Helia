class CustomerRecordController < ApplicationController
  before_action :logged_in_user, only: [:edit, :create, :update, :destroy]
  
  def create
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:email)
				@checkuser = User.find_by(email: params[:email])
				if @checkuser != nil
					@checkprofile = Profile.find_by(user_id: @checkuser.id)
					if @checkprofile != nil
						@customer = CustomerRecord.new(user_id: @checkuser.id, station_id: @station.id, cname: @checkuser.lname + " " + @checkuser.fname, address: @checkuser.address, pnumber: @checkuser.pnumber, avatar: @checkuser.avatar, gender: @checkuser.gender, noid: @checkuser.noid, country: @checkuser.country, city: @checkuser.city, province: @checkuser.province, issue_date: @checkuser.issue_date, issue_place: @checkuser.issue_place, dob: @checkuser.dob)
						if @customer.save
							render json: @customer
						else
							render json: @customer.errors, status: :unprocessable_entity
						end
					end
				end
			else
				if params.has_key?(:avatar)
					@customer = CustomerRecord.new(station_id: @station.id, cname: params[:cname], address: params[:address], pnumber: params[:pnumber], avatar: params[:avatar], gender: params[:gender], noid: params[:noid], dob: params[:dob])
					if @customer.save
						render json: @customer
					else
						render json: @customer.errors, status: :unprocessable_entity
					end
				else
					@customer = CustomerRecord.new(station_id: @station.id, cname: params[:cname], address: params[:address], pnumber: params[:pnumber], gender: params[:gender], noid: params[:noid], dob: params[:dob])
					if @customer.save
						render json: @customer
					else
						render json: @customer.errors, status: :unprocessable_entity
					end
				end
			end
		else
      redirect_to root_path
    end
  end

  def update
		if has_station?
      @station = Station.find_by(user_id: current_user.id)
			@customer = CustomerRecord.find(params[:id])
			if @customer.station_id == @station.id
				if params.has_key?(:avatar)
					if @customer.update(cname: params[:cname],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender],avatar: params[:avatar],dob: params[:dob])
						render json: @customer
					else
						render json: @customer.errors, status: :unprocessable_entity
					end
				else
					if @customer.update(cname: params[:cname],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender], dob: params[:dob])
						render json: @customer
					else
						render json: @customer.errors, status: :unprocessable_entity
					end
				end
			end
    else
      redirect_to root_path
    end
  end

  def destroy
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@customer = CustomerRecord.find(params[:id])
			if @customer.station_id == @station.id
				@customer.destroy
				head :no_content
			end
		else
			redirect_to root_path
		end
	end

  def list
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@data = []
			@data[0] = CustomerRecord.where(station_id: @station.id).order(updated_at: :desc).limit(1000)
			@data[1] = Gender.where(lang: 'vi')
			render json: @data
		else
      redirect_to root_path
    end
	end
  
  
  def find_record
		if has_station?
      @station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:email)
				@customer = User.find_by(email: params[:email])
				if @customer != nil
					@profile = Profile.find_by(user_id: @customer.id)
				else
					@profile = nil
				end
				if @profile == nil
				  @record = nil
				else
					@record = CustomerRecord.find_by(customer_id: @customer.id, station_id: @station.id)
			  end
			  @data = []
			  @data[0] = @profile
			  @data[1] = @record
			  if @customer == nil
					@data[2] = nil
				else
					@data[2] = @customer.id
			  end
			  render json: @data
			end
    else
      redirect_to root_path
		end
	end
	
	def add_record
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:id)
				@customeruser = User.find(params[:id])
				if @customeruser != nil
					@profile = Profile.find_by(user_id: @customeruser.id)
					if @profile != nil
					  @record = CustomerRecord.find_by(customer_id: params[:id], station_id: @station.id)
				    if @record == nil
					    @record = CustomerRecord.new(customer_id: @customeruser.id, station_id: @station.id, cname: @profile.lname + " " + @profile.fname, dob: @profile.dob, gender: @profile.gender, country: @profile.country, city: @profile.city, province: @profile.province, address: @profile.address, pnumber: @profile.pnumber, noid: @profile.noid, issue_date: @profile.issue_date, issue_place: @profile.issue_place, avatar: @profile.avatar)
							if @record.save
								render json: @record
							else
								render json: @record.errors, status: :unprocessable_entity
							end
						end
				  end
				end
			end
	  else
			redirect_to root_path
		end
	end
	
	def link_record
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:id) && params.has_key?(:idrecord)
				@customeruser = User.find(params[:id])
				if @customeruser != nil
					@record = CustomerRecord.find_by(id: params[:idrecord], customer_id: nil, station_id: @station.id)
				  if @record != nil
					  if @record.update(customer_id: @customeruser.id)
							render json: @record
						else
							render json: @record.errors, status: :unprocessable_entity
						end
				  end
				end
			end
	  else
			redirect_to root_path
		end
	end
	
	def clear_link_record
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:idrecord)
				@record = CustomerRecord.find_by(id: params[:idrecord], station_id: @station.id)
				if @record != nil
				  if @record.update(customer_id: nil)
						render json: @record
					else
						render json: @record.errors, status: :unprocessable_entity
					end
				end
			end
	  else
			redirect_to root_path
		end
	end
	
	def update_record
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:id) && params.has_key?(:idrecord)
				@customeruser = User.find(params[:id])
				if @customeruser != nil
					@profile = Profile.find_by(user_id: @customeruser.id)
					if @profile != nil
						@record = CustomerRecord.find_by(id: params[:idrecord], customer_id: @customeruser.id, station_id: @station.id)
						if @record != nil
					    if @record.update(customer_id: @customeruser.id, station_id: @station.id, cname: @profile.lname + " " + @profile.fname, dob: @profile.dob, gender: @profile.gender, country: @profile.country, city: @profile.city, province: @profile.province, address: @profile.address, pnumber: @profile.pnumber, noid: @profile.noid, issue_date: @profile.issue_date, issue_place: @profile.issue_place, avatar: @profile.avatar)
							  render json: @record
						  else
							  render json: @record.errors, status: :unprocessable_entity
						  end
					  end
				  end
				end
			end
	  else
			redirect_to root_path
		end
	end
	
  
  def search
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:cname)
          @supplier = CustomerRecord.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).limit(3)
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
