class UsersController < ApplicationController 
  def show
		if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
		  redirect_to root_url
		else
			redirect_to signup_path
		end
  end

  def usershow
		if logged_in?
			@user = current_user
		  @has_profile = has_profile?
		  @has_station = has_station?
		  @has_dprofile = has_doctor_profile?
			redirect_to root_url
		else
			render 'new'
		end
  end
  
  def create
  	@user = User.new(user_params)
  	if @user.save
			@user.send_activation_email
      redirect_to root_url
  	else
  		render 'new'
  	end
  end
  
  def check_email
		@user = User.find_by_email(params[:user][:email])
		respond_to do |format|
			format.json { render :json => !@user }
		end
	end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
