class RoomController < ApplicationController
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
			render json: Room.where(station_id: @station.id)
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
