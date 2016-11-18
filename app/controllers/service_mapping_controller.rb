class ServiceMappingController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create, :update, :list, :search, :find]
  
  def create
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 1
  			@station = Station.find params[:id_station]
	  	  @s_id = Service.find_by(id: params[:s_id], sname: params[:sname], station_id: @station.id)
		    if !@s_id.nil?
					@s_id = @s_id.id
				end
	  	  @r_id = Room.find_by(id: params[:r_id], name: params[:rname], station_id: @station.id)
		    if !@r_id.nil?
					@r_id = @r_id.id
				end
	  	  @position = ServiceMap.new(station_id: @station.id, service_id: @s_id, sname: params[:sname], rname: params[:rname], room_id: @r_id)
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
	  	  @s_id = Service.find_by(id: params[:s_id], sname: params[:sname], station_id: @station.id)
		    if !@s_id.nil?
					@s_id = @s_id.id
				end
	  	  @r_id = Room.find_by(id: params[:r_id], name: params[:rname], station_id: @station.id)
		    if !@r_id.nil?
					@r_id = @r_id.id
				end
	  	  @position = ServiceMap.new(station_id: @station.id, service_id: @s_id, sname: params[:sname], rname: params[:rname], room_id: @r_id)
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
				@posmap = ServiceMap.find(params[:id])
				if @posmap.station_id == @station.id
					@s_id = Service.find_by(id: params[:s_id], sname: params[:sname], station_id: @station.id)
		      if !@s_id.nil?
					  @s_id = @s_id.id
				  end
	  	    @r_id = Room.find_by(id: params[:r_id], name: params[:rname], station_id: @station.id)
		      if !@r_id.nil?
					  @r_id = @r_id.id
				  end
	  	    if @posmap.update(station_id: @station.id, service_id: @s_id, sname: params[:sname], rname: params[:rname], room_id: @r_id)
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
		  	@position = ServiceMap.find(params[:id])
			  if @position.station_id == @station.id
				  @position.destroy
  				head :no_content
	  		end
      end
    else
  		if has_station?
	  		@station = Station.find_by(user_id: current_user.id)
		  	@position = ServiceMap.find(params[:id])
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
			@data[0] = ServiceMap.where(station_id: @station.id)
			render json: @data
		else
      redirect_to root_path
    end
  end
  
  def search
	  if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
        @station = Station.find params[:id_station]
        if params.has_key?(:sname)
          @supplier = ServiceMap.where("sname LIKE ? and station_id = ?" , "%#{params[:sname]}%", @station.id).group(:sname).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:rname)
          @supplier = ServiceMap.where("rname LIKE ? and station_id = ?" , "%#{params[:rname]}%", @station.id).group(:rname).limit(5)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:sname)
          @supplier = ServiceMap.where("sname LIKE ? and station_id = ?" , "%#{params[:sname]}%", @station.id).group(:sname).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:rname)
          @supplier = ServiceMap.where("rname LIKE ? and station_id = ?" , "%#{params[:rname]}%", @station.id).group(:rname).limit(5)
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
        if params.has_key?(:sname)
          @supplier = ServiceMap.where("sname LIKE ? and station_id = ?" , "%#{params[:sname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:rname)
          @supplier = ServiceMap.where("rname LIKE ? and station_id = ?" , "%#{params[:rname]}%", @station.id)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:sname)
          @supplier = ServiceMap.where("sname LIKE ? and station_id = ?" , "%#{params[:sname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:rname)
          @supplier = ServiceMap.where("rname LIKE ? and station_id = ?" , "%#{params[:rname]}%", @station.id)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
	end
end
