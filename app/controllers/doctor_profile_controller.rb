class DoctorProfileController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :update]
  
  def new
    if has_doctor_profile?
			@doctor_profile = DoctorProfile.find_by(user_id: current_user.id)
			@medicinegroup = MedicineGroup.all
      @medicinetype = MedicineType.all
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
			@doctor_profile = DoctorProfile.find_by(user_id: current_user.id)
			render 'show'	
		else
			@doctor_profile = DoctorProfile.new(user_id: current_user.id, fname: params[:doctor_profile][:fname], lname: params[:doctor_profile][:lname], dob: params[:doctor_profile][:dob], gender: params[:doctor_profile][:gender], address: params[:doctor_profile][:address], pnumber: params[:doctor_profile][:pnumber], noid: params[:doctor_profile][:noid], issue_date: params[:doctor_profile][:issue_date], issue_place: params[:doctor_profile][:issue_place], avatar: params[:doctor_profile][:avatar])
			if @doctor_profile.save
				@dprofile = @doctor_profile
				@medicinegroup = MedicineGroup.all
				@medicinetype = MedicineType.all
				render 'show'
			else
				render 'new'
			end
    end
  end

  def update
		if has_doctor_profile?
      @doctor_profile = DoctorProfile.find_by(user_id: current_user.id)
			if params.has_key?(:avatar)
				if @doctor_profile.update(fname: params[:fname],lname: params[:lname], dob: params[:dob], noid: params[:noid], address: params[:address],avatar: params[:avatar], issue_date: params[:issue_date], issue_place: params[:issue_place], pnumber: params[:pnumber])
					render json: @doctor_profile
				else
					render json: @doctor_profile.errors, status: :unprocessable_entity
				end
			else
				if @doctor_profile.update(fname: params[:fname],lname: params[:lname], dob: params[:dob], noid: params[:noid], address: params[:address], issue_date: params[:issue_date], issue_place: params[:issue_place], pnumber: params[:pnumber])
					render json: @doctor_profile
				else
					render json: @doctor_profile.errors, status: :unprocessable_entity
				end
			end
    else
      head :no_content
    end
  end

  def show
		@doctor_profile = DoctorProfile.find_by(user_id: current_user.id)
		@medicinegroup = MedicineGroup.all
    @medicinetype = MedicineType.all
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
