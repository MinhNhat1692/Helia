class DoctorProfileController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show]
  
  def new
    if has_doctor_profile?
			@dpro = DoctorProfile.find_by(user_id: current_user.id)
			render 'show'
		else
      if has_profile?
        @pro = Profile.find_by(user_id: current_user.id)
      else
        @pro = Profile.new
      end
      @dpro = DoctorProfile.new
    end
  end

  def create
    if has_doctor_profile?
			render 'show'	
		else
			@dpro = DoctorProfile.new(user_id: current_user.id, fname: params[:doctor_profile][:fname], lname: params[:doctor_profile][:lname], dob: params[:doctor_profile][:dob], gender: params[:doctor_profile][:gender], country: params[:doctor_profile][:country], city: params[:doctor_profile][:city], province: params[:doctor_profile][:province], address: params[:doctor_profile][:address], pnumber: params[:doctor_profile][:pnumber], noid: params[:doctor_profile][:noid], issue_date: params[:doctor_profile][:issue_date], issue_place: params[:doctor_profile][:issue_place], avatar: params[:doctor_profile][:avatar])
			if @dpro.save
				@dprofile = @dpro
				render 'show'
			else
				render 'new'
			end
    end
  end

  def show
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
