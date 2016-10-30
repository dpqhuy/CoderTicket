class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :regions, :categories, :venues
  before_filter proc { |controller| (controller.action_has_layout = false) if controller.request.xhr? }

  def current_user
		return @current_user if @current_user
		if session[:user_id]
			@current_user = User.find(session[:user_id])	
		end
	end

	def signed_in?
		if current_user.present?
			return current_user
		end
		return nil
	end

  def regions
    return Region.all
  end

  def categories
    return Category.all
  end

  def venues
    return Venue.all
  end

  def require_login
  	unless signed_in?
  		redirect_to login_path, notice: "You must sign in to see this page!"
  	end
  end

  def skip_if_logged_in
  	if signed_in?
  		redirect_to user_path, notice: "You must sign in to see this page!"
  	end
  end
end
