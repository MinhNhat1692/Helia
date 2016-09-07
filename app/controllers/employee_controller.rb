class EmployeeController < ApplicationController
  before_action :logged_in_user, only: [:edit, :create, :update, :destroy]
  
  def create
    if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:email)
				@checkuser = User.find_by(email: params[:email])
				if @checkuser != nil
					@checkdprofile = DoctorProfile.find_by(user_id: @checkuser.id)
					if @checkdprofile != nil
						@employee = Employee.new(user_id: @checkuser.id, station_id: @station.id, ename: params[:ename], address: params[:address], pnumber: params[:pnumber], avatar: params[:avatar], gender: params[:gender], noid: params[:noid])
						if @employee.save
							render json: @employee
							@employee.send_activation_email(@checkuser,@station,@employee)
						else
							render json: @employee.errors, status: :unprocessable_entity
						end
					else
						@employee = Employee.new(station_id: @station.id, ename: params[:ename], address: params[:address], pnumber: params[:pnumber], avatar: params[:avatar], gender: params[:gender], noid: params[:noid])
						if @employee.save
							render json: @employee
						else
							render json: @employee.errors, status: :unprocessable_entity
						end
					end
				else
					@employee = Employee.new(station_id: @station.id, ename: params[:ename], address: params[:address], pnumber: params[:pnumber], avatar: params[:avatar], gender: params[:gender], noid: params[:noid])
					if @employee.save
						render json: @employee
					else
						render json: @employee.errors, status: :unprocessable_entity
					end
				end
			else
				@employee = Employee.new(station_id: @station.id, ename: params[:ename], address: params[:address], pnumber: params[:pnumber], avatar: params[:avatar], gender: params[:gender], noid: params[:noid])
				if @employee.save
					render json: @employee
				else
					render json: @employee.errors, status: :unprocessable_entity
				end
			end
		else
      redirect_to root_path
    end
  end
  
  def update
		if has_station?
      @station = Station.find_by(user_id: current_user.id)
			@employee = Employee.find(params[:id])
			if @employee.station_id == @station.id
				if params.has_key?(:avatar)
					if @employee.update(ename: params[:ename],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender],avatar: params[:avatar])
						render json: @employee
					else
						render json: @employee.errors, status: :unprocessable_entity
					end
				else
					if @employee.update(ename: params[:ename],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender])
						render json: @employee
					else
						render json: @employee.errors, status: :unprocessable_entity
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
			@employee = Employee.find(params[:id])
			if @employee.station_id == @station.id
				@employee.destroy
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
			@data[0] = Employee.where(station_id: @station.id)
			@data[1] = Gender.where(lang: 'vi')
			render json: @data
		else
      redirect_to root_path
    end
	end
  
  
  def activate
		if params.has_key?(:token)
			@employee = Employee.find_by(activation_digest: params[:token])
			if @employee != nil
				@employee.activate(@employee)
				render json: @employee
			else
				redirect_to root_path
			end
		else
			redirect_to root_path
		end
	end
  
  def find_record
		if has_station?
      @station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:email)
				@doctor = User.find_by(email: params[:email])
				if @doctor != nil
					@profile = DoctorProfile.find_by(user_id: @doctor.id)
				else
					@profile = nil
				end
				if @profile == nil
				  @record = nil
				else
					@record = Employee.find_by(user_id: @doctor.id, station_id: @station.id)
			  end
			  @data = []
			  @data[0] = @profile
			  @data[1] = @record
			  if @doctor == nil
					@data[2] = nil
				else
					@data[2] = @doctor.id
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
					@profile = DoctorProfile.find_by(user_id: @customeruser.id)
					if @profile != nil
					  @record = Employee.find_by(user_id: params[:id], station_id: @station.id)
				    if @record == nil
					    @record = Employee.new(user_id: @customeruser.id, station_id: @station.id, ename: @profile.lname + " " + @profile.fname, gender: @profile.gender, country: @profile.country, city: @profile.city, province: @profile.province, address: @profile.address, pnumber: @profile.pnumber, noid: @profile.noid, avatar: @profile.avatar)
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
					@record = Employee.find_by(id: params[:idrecord], user_id: nil, station_id: @station.id)
				  if @record != nil
					  if @record.update(user_id: @customeruser.id)
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
				@record = Employee.find_by(id: params[:idrecord], station_id: @station.id)
				if @record != nil
				  if @record.update(user_id: nil)
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
					@profile = DoctorProfile.find_by(user_id: @customeruser.id)
					if @profile != nil
						@record = Employee.find_by(id: params[:idrecord], user_id: @customeruser.id, station_id: @station.id)
						if @record != nil
					    if @record.update(user_id: @customeruser.id, station_id: @station.id, ename: @profile.lname + " " + @profile.fname, gender: @profile.gender, country: @profile.country, city: @profile.city, province: @profile.province, address: @profile.address, pnumber: @profile.pnumber, noid: @profile.noid, avatar: @profile.avatar)
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
