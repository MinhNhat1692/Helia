class CustomerRecordController < ApplicationController
  before_action :logged_in_user, only: [:edit, :create, :update, :destroy]
  
  def create
    @station = Station.find_by(user_id: current_user.id)
    @record = CustomerRecord.new(station_id: @station.id, avatar: params[:avatar])
		if @record.save
			render json: @record
		else
		  render json: @record.errors, status: :unprocessable_entity
		end
  end

  def update
  end

  def destroy
  end

  def list
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@data = []
			@data[0] = CustomerRecord.where(station_id: @station.id).order(updated_at: :desc).limit(1000)
			@data[1] = Gender.where(lang: 'vi')
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
