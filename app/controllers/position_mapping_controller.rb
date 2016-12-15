class PositionMappingController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create, :update, :list, :search, :find]
  
  def create
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 1
  			@station = Station.find params[:id_station]
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
        head :no_content
      end
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
      if current_user.check_permission params[:id_station], params[:table_id], 3
	  		@station = Station.find params[:id_station]
		  	@position = PositionMapping.find(params[:id])
			  if @position.station_id == @station.id
				  @position.destroy
  				head :no_content
	  		end
      end
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
      if params.has_key?(:date)
        n = params[:date].to_i
        start = n.days.ago.beginning_of_day
        fin = Time.now
        @data[0] = PositionMapping.where(station_id: @station.id, created_at: start..fin)
      elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
        start = params[:begin_date].to_date.beginning_of_day
        fin = params[:end_date].to_date.end_of_day
        @data[0] = PositionMapping.where(station_id: @station.id, created_at: start..fin)
      else
			  @data[0] = PositionMapping.where(station_id: @station.id)
      end
			render json: @data
		else
      redirect_to root_path
    end
  end
  
  def search
	  if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
        @station = Station.find params[:id_station]
        if params.has_key?(:ename)
          @supplier = PositionMapping.where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id).group(:ename).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:pname)
          @supplier = PositionMapping.where("pname LIKE ? and station_id = ?" , "%#{params[:pname]}%", @station.id).group(:pname).limit(5)
			    render json:@supplier
			  end
      else
        head :no_content
      end
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
      if current_user.check_permission params[:id_station], params[:table_id], 4
        @station = Station.find params[:id_station]
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
        else
          start = PositionMapping.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:ename)
          @supplier = PositionMapping.where(created_at: start..fin).where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:pname)
          @supplier = PositionMapping.where(created_at: start..fin).where("pname LIKE ? and station_id = ?" , "%#{params[:pname]}%", @station.id)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
        else
          start = PositionMapping.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:ename)
          @supplier = PositionMapping.where(created_at: start..fin).where("ename LIKE ? and station_id = ?" , "%#{params[:ename]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:pname)
          @supplier = PositionMapping.where(created_at: start..fin).where("pname LIKE ? and station_id = ?" , "%#{params[:pname]}%", @station.id)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
	end
end
