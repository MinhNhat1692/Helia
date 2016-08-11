class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "Welcome to Helia"
  		redirect_to @user
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
