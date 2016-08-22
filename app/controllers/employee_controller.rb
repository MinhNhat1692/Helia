class EmployeeController < ApplicationController
  before_action :logged_in_user, only: [:edit, :create, :update]
  
  def create
    if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@employee = Employee.new(station_id: @station.id, ename: params[:record][:ename])
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
