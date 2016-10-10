class HomeController < ApplicationController
  def index
    if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		else
      @has_profile = false
		  @has_station = false
		  @has_dprofile = false
    end
  end
end
