class UsersController < ApplicationController
  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash.now[:success] = "Sign Up Successfully!"
  		session[:user_id] = @user.id
  	else
  		flash.now[:error] = "#{@user.errors.full_messages.to_sentence}"
  	end
  end
  	

  private
  def user_params
  	params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

end
