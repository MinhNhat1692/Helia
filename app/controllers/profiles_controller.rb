class ProfilesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :edit]

  def new
		if has_profile?
			@pro = current_profile
			render 'show'
		else
			render 'new'
		end
  end

  def edit
  end

  def show
  end
  
  def create
		if has_profile?
			@pro = current_profile
			render 'show'	
		else
			@profile = Profile.new(user_id: current_user.id, fname: params[:profile][:fname], lname: params[:profile][:lname], dob: params[:profile][:dob], gender: params[:profile][:gender], country: params[:profile][:country], city: params[:profile][:city], province: params[:profile][:province], address: params[:profile][:address], pnumber: params[:profile][:pnumber], noid: params[:profile][:noid], issue_date: params[:profile][:issue_date], issue_place: params[:profile][:issue_place], avatar: params[:profile][:avatar])
			if @profile.save
				@pro = @profile
				render 'show'
			else
				render 'new'
			end
		end
  end
end
