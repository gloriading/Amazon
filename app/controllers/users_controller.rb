class UsersController < ApplicationController
  # show a sign up page
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id # for user sign in/out
      # (Then go to  ApplicationController )
      flash[:notice] = "Thank you for signing up, #{@user.first_name}!"
      # (Then go to layout/application.html.erb)
      redirect_to home_path
    else
      render :new
    end
  end

private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

end
