module SessionsHelper
    
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end
    
    # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end
    
    # Returns true if the given user is the current user.
    def current_user?(user)
        user == current_user
    end
    
    # Returns the current logged-in user (if any)
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end
    
    def current_apikey
        if (user_id = session[:user_id])
            @current_apikey ||= Apikey.find_by(user_id: user_id)
        end
    end
    
    def has_apikey?
        !current_apikey.nil?
    end
    
    def current_profile
        if (user_id = session[:user_id])
            @current_profile ||= Profile.find_by(user_id: user_id)
        end
    end
    
    def has_profile?
        !current_profile.nil?
    end
    
    def current_doctor_profile
        if (user_id = session[:user_id])
            @current_doctor_profile ||= DoctorProfile.find_by(user_id: user_id)
        end
    end
    
    def has_doctor_profile?
        !current_doctor_profile.nil?
    end
    
    def has_station?
        !current_station.nil?
    end
    
    def current_station
        if (user_id = session[:user_id])
            @current_station ||= Station.find_by(user_id: user_id)
        end
    end
    # Returns true if the user is logged in, false otherwise
    def logged_in?
        !current_user.nil?
    end
    
    # Forgets a persistent session.
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
    
    # Redirects to stored location (or to the default).
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    # Stores the URL trying to be accessed.
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
    
    def logged_in_user
	    unless logged_in?
		    store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
