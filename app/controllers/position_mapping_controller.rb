class PositionMappingController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create, :update, :list]
  
  def create
  end

  def update
  end

  def destroy
  end

  def list
    if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@data = []
			@data[0] = Employee.where(station_id: @station.id)
			@data[1] = Room.where(station_id: @station.id)
			@data[2] = Position.where(station_id: @station.id)
			render json: @data
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
