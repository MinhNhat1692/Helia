class PositionController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy]
  
  def create
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 1
  			@station = Station.find params[:id_station]
	  	  @r_id = Room.find_by(id: params[:r_id], name: params[:rname], station_id: @station.id)
		    if !@r_id.nil?
					@r_id = @r_id.id
				end
	  	  if params.has_key?(:file)
			  	@position = Position.new(station_id: @station.id, room_id: @r_id, rname: params[:rname], pname: params[:pname], lang: params[:lang], description: params[:description], file: params[:file])
				  if @position.save
						render json: @position
  				else
	  				render json: @position.errors, status: :unprocessable_entity
		  		end
			  else
				 	@position = Position.new(station_id: @station.id, room_id: @r_id, rname: params[:rname], pname: params[:pname], lang: params[:lang], description: params[:description], file: params[:file])
				  if @position.save
					  render json: @position
  				else
	  				render json: @position.errors, status: :unprocessable_entity
		  		end
			  end
	    else
        head :no_content
      end
    else
      if has_station?
  			@station = Station.find_by(user_id: current_user.id)
	  	  @r_id = Room.find_by(id: params[:r_id], name: params[:rname], station_id: @station.id)
		    if !@r_id.nil?
					@r_id = @r_id.id
				end
	  	  if params.has_key?(:file)
			  	@position = Position.new(station_id: @station.id, room_id: @r_id, rname: params[:rname], pname: params[:pname], lang: params[:lang], description: params[:description], file: params[:file])
				  if @position.save
						render json: @position
  				else
	  				render json: @position.errors, status: :unprocessable_entity
		  		end
			  else
				 	@position = Position.new(station_id: @station.id, room_id: @r_id, rname: params[:rname], pname: params[:pname], lang: params[:lang], description: params[:description], file: params[:file])
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
  end
  
  def update
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 2
        @station = Station.find params[:id_station]
  			@position = Position.find(params[:id])
	  		if @position.station_id == @station.id
					@r_id = Room.find_by(id: params[:r_id], name: params[:rname], station_id: @station.id)
		      if !@r_id.nil?
					  @r_id = @r_id.id
				  end
	  	    if params.has_key?(:file)
			  	  if @position.update(station_id: @station.id, room_id: @r_id, rname: params[:rname], pname: params[:pname], lang: params[:lang], description: params[:description], file: params[:file])
              render json: @position
  				  else
	  				  render json: @position.errors, status: :unprocessable_entity
		  		  end
			    else
  				 	if @position.update(station_id: @station.id, room_id: @r_id, rname: params[:rname], pname: params[:pname], lang: params[:lang], description: params[:description], file: params[:file])
		  			  render json: @position
  		  		else
	  		  		render json: @position.errors, status: :unprocessable_entity
		  		  end
			    end
	  	  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
  			@position = Position.find(params[:id])
	  		if @position.station_id == @station.id
					@r_id = Room.find_by(id: params[:r_id], name: params[:rname], station_id: @station.id)
		      if !@r_id.nil?
					  @r_id = @r_id.id
				  end
	  	    if params.has_key?(:file)
			  	  if @position.update(station_id: @station.id, room_id: @r_id, rname: params[:rname], pname: params[:pname], lang: params[:lang], description: params[:description], file: params[:file])
              render json: @position
  				  else
	  				  render json: @position.errors, status: :unprocessable_entity
		  		  end
			    else
  				 	if @position.update(station_id: @station.id, room_id: @r_id, rname: params[:rname], pname: params[:pname], lang: params[:lang], description: params[:description], file: params[:file])
		  			  render json: @position
  		  		else
	  		  		render json: @position.errors, status: :unprocessable_entity
		  		  end
			    end
	  	  end
      else
        redirect_to root_path
      end
    end
  end
  
  def destroy
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 3
	  		@station = Station.find params[:id_station]
		  	@position = Position.find(params[:id])
			  if @position.station_id == @station.id
				  @position.destroy
  				head :no_content
	  		end
      end
    else
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
  end
  
  def list
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
	  		@station = Station.find params[:id_station]
		  	@data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
			    @data[0] = Position.where(station_id: @station.id, created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
			    @data[0] = Position.where(station_id: @station.id, created_at: start..fin)
        else
			    @data[0] = Position.where(station_id: @station.id)
        end
  			render json: @data
		  else
        head :no_content
      end
    else
      if has_station?
	  		@station = Station.find_by(user_id: current_user.id)
		  	@data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
			    @data[0] = Position.where(station_id: @station.id, created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
			    @data[0] = Position.where(station_id: @station.id, created_at: start..fin)
        else
			    @data[0] = Position.where(station_id: @station.id)
        end
  			render json: @data
		  else
        redirect_to root_path
      end
    end
  end
  
  def search
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
        @station = Station.find params[:id_station]
        if params.has_key?(:pname)
          @supplier = Position.where("pname LIKE ? and station_id = ?" , "%#{params[:pname]}%", @station.id).group(:pname).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:description)
          @supplier = Position.where("description LIKE ? and station_id = ?" , "%#{params[:description]}%", @station.id).group(:description).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:rname)
          @supplier = Position.where("rname LIKE ? and station_id = ?" , "%#{params[:rname]}%", @station.id).group(:rname).limit(5)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:pname)
          @supplier = Position.where("pname LIKE ? and station_id = ?" , "%#{params[:pname]}%", @station.id).group(:pname).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:description)
          @supplier = Position.where("description LIKE ? and station_id = ?" , "%#{params[:description]}%", @station.id).group(:description).limit(5)
			    render json:@supplier
			  elsif params.has_key?(:rname)
          @supplier = Position.where("rname LIKE ? and station_id = ?" , "%#{params[:rname]}%", @station.id).group(:rname).limit(5)
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
          start = Position.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:pname)
          @supplier = Position.where(created_at: start..fin).where("pname LIKE ? and station_id = ?" , "%#{params[:pname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:description)
          @supplier = Position.where(created_at: start..fin).where("description LIKE ? and station_id = ?" , "%#{params[:description]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:rname)
          @supplier = Position.where(created_at: start..fin).where("rname LIKE ? and station_id = ?" , "%#{params[:rname]}%", @station.id)
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
          start = Position.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:pname)
          @supplier = Position.where(created_at: start..fin).where("pname LIKE ? and station_id = ?" , "%#{params[:pname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:description)
          @supplier = Position.where(created_at: start..fin).where("description LIKE ? and station_id = ?" , "%#{params[:description]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:rname)
          @supplier = Position.where(created_at: start..fin).where("rname LIKE ? and station_id = ?" , "%#{params[:rname]}%", @station.id)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
  end
end
