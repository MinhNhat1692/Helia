class ServiceController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create, :update, :list, :search, :find]
  
  def create
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 1
			  @station = Station.find params[:id_station]
  			if params.has_key?(:file)
          @service = Service.new(station_id: @station.id, sname: params[:sname], lang: params[:lang], price: params[:price], currency: params[:currency], description: params[:description],file: params[:file])
          if @service.save
            render json: @service
          else
            render json: @service.errors, status: :unprocessable_entity
          end
        else
          @service = Service.new(station_id: @station.id, sname: params[:sname], lang: params[:lang], price: params[:price], currency: params[:currency], description: params[:description])
          if @service.save
            render json: @service
          else
            render json: @service.errors, status: :unprocessable_entity
          end
        end
		  else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
  			if params.has_key?(:file)
          @service = Service.new(station_id: @station.id, sname: params[:sname], lang: params[:lang], price: params[:price], currency: params[:currency], description: params[:description],file: params[:file])
          if @service.save
            render json: @service
          else
            render json: @service.errors, status: :unprocessable_entity
          end
        else
          @service = Service.new(station_id: @station.id, sname: params[:sname], lang: params[:lang], price: params[:price], currency: params[:currency], description: params[:description])
          if @service.save
            render json: @service
          else
            render json: @service.errors, status: :unprocessable_entity
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
		  	@service = Service.find(params[:id])
			  if @station.id == @service.station_id
				  if params.has_key?(:file)
            if @service.update(sname: params[:sname], lang: params[:lang], price: params[:price], currency: params[:currency], description: params[:description], file: params[:file])
              render json: @service
            else
              render json: @service.errors, status: :unprocessable_entity
            end
          else
            if @service.update(sname: params[:sname], lang: params[:lang], price: params[:price], currency: params[:currency], description: params[:description])
              render json: @service
            else
              render json: @service.errors, status: :unprocessable_entity
            end
          end
	  		end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
		  	@service = Service.find(params[:id])
			  if @station.id == @service.station_id
				  if params.has_key?(:file)
            if @service.update(sname: params[:sname], lang: params[:lang], price: params[:price], currency: params[:currency], description: params[:description], file: params[:file])
              render json: @service
            else
              render json: @service.errors, status: :unprocessable_entity
            end
          else
            if @service.update(sname: params[:sname], lang: params[:lang], price: params[:price], currency: params[:currency], description: params[:description])
              render json: @service
            else
              render json: @service.errors, status: :unprocessable_entity
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
		  	@service = Service.find(params[:id])
			  if @service.station_id == @station.id
				  @service.destroy
  				head :no_content
	  		end
      end
    else
      if has_station?
	  		@station = Station.find_by(user_id: current_user.id)
		  	@service = Service.find(params[:id])
			  if @service.station_id == @station.id
				  @service.destroy
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
          @data[0] = Service.where(station_id: @station.id, created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = Service.where(station_id: @station.id, created_at: start..fin)
        else
			    @data[0] = Service.where(station_id: @station.id)
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
          @data[0] = Service.where(station_id: @station.id, created_at: start..fin)
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
          @data[0] = Service.where(station_id: @station.id, created_at: start..fin)
        else
			    @data[0] = Service.where(station_id: @station.id)
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
        if params.has_key?(:sname)
          @supplier = Service.where("sname LIKE ? and station_id = ?" , "%#{params[:sname]}%", @station.id).group(:sname).limit(5)
			    render json:@supplier
        elsif params.has_key?(:description)
				  @supplier = Service.where("description LIKE ? and station_id = ?" , "%#{params[:description]}%", @station.id).group(:description).limit(5)
			    render json:@supplier
			  end
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:sname)
          @supplier = Service.where("sname LIKE ? and station_id = ?" , "%#{params[:sname]}%", @station.id).group(:sname).limit(5)
			    render json:@supplier
        elsif params.has_key?(:description)
				  @supplier = Service.where("description LIKE ? and station_id = ?" , "%#{params[:description]}%", @station.id).group(:description).limit(5)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
    end
  end

  def find
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 4
        @station = Station.find params[:id_station]
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
        else
          start = Service.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:sname)
          @supplier = Service.where(created_at: start..fin).where("sname LIKE ? and station_id = ?" , "%#{params[:sname]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:description)
				  @supplier = Service.where(created_at: start..fin).where("description LIKE ? and station_id = ?" , "%#{params[:description]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:price)
				  @supplier = Service.where(created_at: start..fin).where("price = ? and station_id = ?" , "%#{params[:price]}%", @station.id)
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
          start = Service.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:sname)
          @supplier = Service.where(created_at: start..fin).where("sname LIKE ? and station_id = ?" , "%#{params[:sname]}%", @station.id)
			    render json:@supplier
        elsif params.has_key?(:description)
				  @supplier = Service.where(created_at: start..fin).where("description LIKE ? and station_id = ?" , "%#{params[:description]}%", @station.id)
			    render json:@supplier
			  elsif params.has_key?(:price)
				  @supplier = Service.where(created_at: start..fin).where("price = ? and station_id = ?" , "%#{params[:price]}%", @station.id)
			    render json:@supplier
			  end
      else
        redirect_to root_path
      end
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
