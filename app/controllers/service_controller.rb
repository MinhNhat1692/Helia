class ServiceController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create, :update, :list]
  
  def create
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


  def update
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

  
  def destroy
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

  def list
    if has_station?
			@station = Station.find_by(user_id: current_user.id)
			render json: Service.where(station_id: @station.id)
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
