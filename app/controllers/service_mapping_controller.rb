class ServiceMappingController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create, :update, :list]
  
  def create
  end

  def update
    if has_station?
      @station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:id)
				@service = Service.find(params[:id])
				if @service.station_id == @station.id
					if params.has_key?(:sname)
						if @service.update(sname: params[:sname])
							render json:@service
						else
							render json: @service.errors, status: :unprocessable_entity
						end		
					elsif params.has_key?(:description)
						if @service.update(description: params[:description])
							render json:@service
						else
							render json: @service.errors, status: :unprocessable_entity
						end 
					elsif params.has_key?(:file)
						if @service.update(file: params[:file])
							render json:@service
						else
							render json: @service.errors, status: :unprocessable_entity
						end
					elsif params.has_key?(:price)
						if @service.update(price: params[:price])
							render json:@service
						else
							render json: @service.errors, status: :unprocessable_entity
						end
					elsif params.has_key?(:sermap)
						@pos = ServiceMap.find_by(station_id: @station.id, service_id: @service.id)
						if @pos.nil?
							@pos = ServiceMap.new(station_id: @station.id, service_id: @service.id, room_id: params[:sermap])
							if @pos.save
								render json: @pos
							else
								render json: @pos.errors, status: :unprocessable_entity
							end
						else
							if @pos.update(room_id: params[:sermap])
								render json: @pos
							else
								render json: @pos.errors, status: :unprocessable_entity
							end
						end
					end
				end
			end
    else
      redirect_to root_path
		end
  end

  def destroy
  end

  def list
    if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@data = []
			@data[0] = Service.where(station_id: @station.id)
			@data[1] = Room.where(station_id: @station.id)
			@data[2] = ServiceMap.where(station_id: @station.id)
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
