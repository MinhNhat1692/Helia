class StationController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show]
  
  def new
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			@user = current_user
			@records = Employee.all
			render 'show'
		else
      @station = Station.new
		end
  end

  def edit
  end

  def show
  end

  def create
		if has_station?
			render 'show'	
		else
			@station = Station.new(user_id: current_user.id, sname: params[:station][:sname], country: params[:station][:country], city: params[:station][:city], province: params[:station][:province], address: params[:station][:address], pnumber: params[:station][:pnumber], logo: params[:station][:logo])
			if @station.save
				@user = current_user
				render 'show'
			else
				render 'new'
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
