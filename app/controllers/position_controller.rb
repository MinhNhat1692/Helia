class PositionController < ApplicationController
  before_action :logged_in_user, only: [:list, :create, :update, :destroy]
  
  def create
		if params.has_key?(:id_station)
      redirect_to root_path
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
      redirect_to root_path
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
      redirect_to root_path
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
      redirect_to root_path
    else
      if has_station?
	  		@station = Station.find_by(user_id: current_user.id)
		  	@data = []
			  @data[0] = Position.where(station_id: @station.id)
  			render json: @data
		  else
        redirect_to root_path
      end
    end
  end
  
  def search
    if params.has_key?(:id_station)
      redirect_to root_path
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
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:pname)
          @supplier = Position.where("pname LIKE ? and station_id = ?" , "%#{params[:pname]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:description)
          @supplier = Position.where("description LIKE ? and station_id = ?" , "%#{params[:description]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:rname)
          @supplier = Position.where("rname LIKE ? and station_id = ?" , "%#{params[:rname]}%", @station.id)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
  end
end
