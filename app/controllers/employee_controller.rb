class EmployeeController < ApplicationController
  before_action :logged_in_user, only: [:edit, :create, :update, :destroy]
  
  def create
    if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@employee = Employee.new(station_id: @station.id, ename: params[:ename], address: params[:address], pnumber: params[:pnumber], avatar: params[:avatar], gender: params[:gender], noid: params[:noid])
			if @employee.save
        render json: @employee
      else
        render json: @employee.errors, status: :unprocessable_entity
			end
		else
      redirect_to root_path
    end
  end

  def edit
  end

  def update
		@employee = Employee.find(params[:id])
    if @employee.update(ename: params[:ename])
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
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
