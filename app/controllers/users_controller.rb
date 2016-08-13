class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end
  
  def show
  	@user = User.find(params[:id])
  	redirect_to root_url and return unless @user.activated
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
			@user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
  	else
  		render 'new'
  	end
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
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
  	
  	# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end
  
  	# Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
