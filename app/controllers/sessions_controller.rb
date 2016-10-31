class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_url
    else
      render 'new'  
    end
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or root_url
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:error] = message
        redirect_to root_url
      end
    else
      # Create an error message.
      flash[:error] = 'Mật khẩu hoặc Email không chính xác' # Not quite right!
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
