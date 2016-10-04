class PositionMappingController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create, :update, :list, :search, :find]
  
  def create
		if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
  			@station = Station.find_by(user_id: current_user.id)
	  	  @e_id = Employee.find_by(id: params[:e_id], ename: params[:ename], station_id: @station.id)
		    if !@e_id.nil?
					@e_id = @e_id.id
				end
	  	  @p_id = Position.find_by(id: params[:p_id], pname: params[:pname], station_id: @station.id)
		    if !@p_id.nil?
					@p_id = @p_id.id
				end
	  	  @position = PositionMapping.new(station_id: @station.id, employee_id: @e_id, ename: params[:ename], pname: params[:pname], position_id: @p_id)
				if @position.save
					render json: @position
  			else
	  			render json: @position.errors, status: :unprocessable_entity
		  	end
	    else
        redirect_to root_path
      end
    end
  end

  def update
		if has_station?
      @station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:id)
				@posmap = PositionMapping.find(params[:id])
				if @posmap.station_id == @station.id
					@e_id = Employee.find_by(id: params[:e_id], ename: params[:ename], station_id: @station.id)
		      if !@e_id.nil?
					  @e_id = @e_id.id
				  end
	  	    @p_id = Position.find_by(id: params[:p_id], pname: params[:pname], station_id: @station.id)
		      if !@p_id.nil?
					  @p_id = @p_id.id
				  end
	  	    if @posmap.update(station_id: @station.id, employee_id: @e_id, ename: params[:ename], pname: params[:pname], position_id: @p_id)
					  render json: @posmap
  			  else
	  			  render json: @posmap.errors, status: :unprocessable_entity
		  	  end
				end
			end
    else
      redirect_to root_path
		end
  end

  def destroy
    if params.has_key?(:id_station)
      redirect_to root_path
    else
  		if has_station?
	  		@station = Station.find_by(user_id: current_user.id)
		  	@position = PositionMapping.find(params[:id])
			  if @position.station_id == @station.id
				  @position.destroy
  				head :no_content
	  		end
		  else
			  redirect_to root_path
  		end
	  end
  end

  def list
    if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@data = []
			@data[0] = PositionMapping.where(station_id: @station.id)
			render json: @data
		else
      redirect_to root_path
    end
  end
  
  def search
	  if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:ename)
          @supplier = PositionMapping.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id).group(:ename).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:pname)
          @supplier = PositionMapping.where("pname LIKE ? and station_id = ?" , "%#{params[:pname]}%", @station.id).group(:pname).limit(5)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
	end
  
  def find
		if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:ename)
          @supplier = PositionMapping.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:pname)
          @supplier = PositionMapping.where("pname LIKE ? and station_id = ?" , "%#{params[:pname]}%", @station.id)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
	end
end
