class PositionController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy]
  
  def create
    if has_station?
			@station = Station.find_by(user_id: current_user.id)
		  if Room.find_by(params[:room]).station_id == @station.id	
				@position = Position.new(station_id: @station.id, room_id: params[:room], pname: params[:pname], lang: params[:lang], description: params[:description], file: params[:file])
				if @position.save
					render json: @position
				else
					render json: @position.errors, status: :unprocessable_entity
				end
			end
		else
      redirect_to root_path
    end
  end

  def update
    if has_station?
      @station = Station.find_by(user_id: current_user.id)
			@position = Position.find(params[:id])
			if @position.update(room_id: params[:room], pname: params[:pname],lang: params[:lang], description: params[:description], file: params[:file])
        render json: @position
      else
        render json: @position.errors, status: :unprocessable_entity
      end
    else
      redirect_to root_path
    end
  end

  def destroy
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@position = Position.find(params[:id])
			if @position.station_id == @station.id
				@position.destroy
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
			@data[0] = Position.where(station_id: @station.id)
			@data[1] = Room.where(station_id: @station.id)
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
