class PositionMappingController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create, :update, :list]
  
  def create
  end

  def update
		if has_station?
      @station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:id)
				@employee = Employee.find(params[:id])
				if @employee.station_id == @station.id
					if params.has_key?(:ename)
						if @employee.update(ename: params[:ename])
							render json:@employee
						else
							render json: @employee.errors, status: :unprocessable_entity
						end		
					elsif params.has_key?(:address)
						if @employee.update(address: params[:address])
							render json:@employee
						else
							render json: @employee.errors, status: :unprocessable_entity
						end 
					elsif params.has_key?(:avatar)
						if @employee.update(avatar: params[:avatar])
							render json:@employee
						else
							render json: @employee.errors, status: :unprocessable_entity
						end
					elsif params.has_key?(:noid)
						if @employee.update(noid: params[:noid])
							render json:@employee
						else
							render json: @employee.errors, status: :unprocessable_entity
						end
					elsif params.has_key?(:pnumber)
						if @employee.update(pnumber: params[:pnumber])
							render json: @employee
						else
							render json: @employee.errors, status: :unprocessable_entity
						end
					elsif params.has_key?(:posmap)
						@pos = PositionMapping.find_by(station_id: @station.id, employee_id: @employee.id)
						if @pos.nil?
							@pos = PositionMapping.new(station_id: @station.id, employee_id: @employee.id, position_id: params[:posmap])
							if @pos.save
								render json: @pos
							else
								render json: @pos.errors, status: :unprocessable_entity
							end
						else
							if @pos.update(position_id: params[:posmap])
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
			@data[0] = Employee.where(station_id: @station.id)
			@data[1] = Room.where(station_id: @station.id)
			@data[2] = Position.where(station_id: @station.id)
			@data[3] = PositionMapping.where(station_id: @station.id)
			@data[4] = @station
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
