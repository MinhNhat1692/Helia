class DoctorProfileController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :update]
  
  def new
    if has_doctor_profile?
			@doctor_profile = DoctorProfile.find_by(user_id: current_user.id)
			render 'show'
		else
      if has_profile?
        @pro = Profile.find_by(user_id: current_user.id)
      else
        @pro = Profile.new
      end
      @doctor_profile = DoctorProfile.new
    end
  end

  def create
    if has_doctor_profile?
			render 'show'	
		else
			@doctor_profile = DoctorProfile.new(user_id: current_user.id, fname: params[:doctor_profile][:fname], lname: params[:doctor_profile][:lname], dob: params[:doctor_profile][:dob], gender: params[:doctor_profile][:gender], address: params[:doctor_profile][:address], pnumber: params[:doctor_profile][:pnumber], noid: params[:doctor_profile][:noid], issue_date: params[:doctor_profile][:issue_date], issue_place: params[:doctor_profile][:issue_place], avatar: params[:doctor_profile][:avatar])
			if @doctor_profile.save
				@dprofile = @doctor_profile
				render 'show'
			else
				render 'new'
			end
    end
  end

  def update
		if has_doctor_profile?
      @station = Station.find_by(user_id: current_user.id)
			@customer = CustomerRecord.find(params[:id])
			if @customer.station_id == @station.id
				if params.has_key?(:avatar)
					if @customer.update(cname: params[:cname],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender],avatar: params[:avatar],dob: params[:dob], issue_date: params[:issue_date], issue_place: params[:issue_place], work_place: params[:work_place], self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
						render json: @customer
					else
						render json: @customer.errors, status: :unprocessable_entity
					end
				else
					if @customer.update(cname: params[:cname],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender], dob: params[:dob], issue_date: params[:issue_date], issue_place: params[:issue_place], work_place: params[:work_place], self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
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

  def show
		@doctor_profile = DoctorProfile.find_by(user_id: current_user.id)
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
