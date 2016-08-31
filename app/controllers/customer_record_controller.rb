class CustomerRecordController < ApplicationController
  before_action :logged_in_user, only: [:edit, :create, :update, :destroy]
  
  def create
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:email)
				@checkuser = User.find_by(email: params[:email])
				if @checkuser != nil
					@checkprofile = Profile.find_by(user_id: @checkuser.id)
					if @checkprofile != nil
						@customer = CustomerRecord.new(user_id: @checkuser.id, station_id: @station.id, cname: @checkuser.lname + " " + @checkuser.fname, address: @checkuser.address, pnumber: @checkuser.pnumber, avatar: @checkuser.avatar, gender: @checkuser.gender, noid: @checkuser.noid, country: @checkuser.country, city: @checkuser.city, province: @checkuser.province, issue_date: @checkuser.issue_date, issue_place: @checkuser.issue_place, dob: @checkuser.dob)
						if @customer.save
							render json: @customer
						else
							render json: @customer.errors, status: :unprocessable_entity
						end
					end
				end
			else
				if params.has_key?(:avatar)
					@customer = CustomerRecord.new(station_id: @station.id, cname: params[:cname], address: params[:address], pnumber: params[:pnumber], avatar: params[:avatar], gender: params[:gender], noid: params[:noid], dob: params[:dob])
					if @customer.save
						render json: @customer
					else
						render json: @customer.errors, status: :unprocessable_entity
					end
				else
					@customer = CustomerRecord.new(station_id: @station.id, cname: params[:cname], address: params[:address], pnumber: params[:pnumber], gender: params[:gender], noid: params[:noid], dob: params[:dob])
					if @customer.save
						render json: @customer
					else
						render json: @customer.errors, status: :unprocessable_entity
					end
				end
			end
		else
      redirect_to root_path
    end
  end

  def update
		if has_station?
      @station = Station.find_by(user_id: current_user.id)
			@customer = CustomerRecord.find(params[:id])
			if @customer.station_id == @station.id
				if params.has_key?(:avatar)
					if @customer.update(cname: params[:cname],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender],avatar: params[:avatar],dob: params[:dob])
						render json: @customer
					else
						render json: @customer.errors, status: :unprocessable_entity
					end
				else
					if @customer.update(cname: params[:cname],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender], dob: params[:dob])
						render json: @customer
					else
						render json: @customer.errors, status: :unprocessable_entity
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
			@customer = CustomerRecord.find(params[:id])
			if @customer.station_id == @station.id
				@customer.destroy
				head :no_content
			end
		else
			redirect_to root_path
		end
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
