class RoomController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create, :update, :list]
  
  def create
    if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@room = Room.new(station_id: @station.id, name: params[:name], lang: params[:lang], map: params[:map])
			if @room.save
        render json: @room
      else
        render json: @room.errors, status: :unprocessable_entity
			end
		else
      redirect_to root_path
    end
  end

  def update
    if has_station?
      @station = Station.find_by(user_id: current_user.id)
			@room = Room.find(params[:id])
			if @station.id == @room.station_id
				if @room.update(name: params[:name],lang: params[:lang],map: params[:map])
					render json: @room
				else
					render json: @room.errors, status: :unprocessable_entity
				end
			end
    else
      redirect_to root_path
    end
  end

  def destroy
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@room = Room.find(params[:id])
			if @room.station_id == @station.id
				@room.destroy
				head :no_content
			end
		else
			redirect_to root_path
		end
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
