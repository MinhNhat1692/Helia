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
