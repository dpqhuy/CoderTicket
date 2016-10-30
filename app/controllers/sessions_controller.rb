class SessionsController < ApplicationController
  before_action :skip_if_logged_in, only: [:create, :new]
  def create
   if @user = User.find_by(email: params[:email])
     if @user.authenticate(params[:password])
       flash.now['success'] = "login successful"
       session[:user_id] = @user.id
     else
       flash.now['error'] = "login invalid"
     end
   else
     flash.now['error'] = "User not found"
   end
  end

  def destroy
    session[:user_id] = nil
    flash.now['notice'] = "Logged out."
    redirect_to events_path
  end
end
