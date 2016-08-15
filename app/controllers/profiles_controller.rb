class ProfilesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :edit]

  def new
		if has_profile?
			render 'show'
		else
			@profile = Profile.new
		end
  end

  def edit
  end

  def show
  end
  
  def create
		if has_profile?
			render 'show'	
		else
			@profile = Profile.new(profile_params(current_user))
			if @profile.save
				render 'show'
			else
				render 'new'
			end
		end
  end
  
  private
		def profile_params(user)
  		params.require(:profile).permit(user.id, :fname, :lname, :dob, :gender, :country, :city, :province, :address, :pnumber, :noid, :issue_date, :issue_place, :avatar)
		end
  
  	# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end
end
