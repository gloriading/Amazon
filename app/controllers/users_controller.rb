class UsersController < ApplicationController
before_action :authenticate_user!, only: [:edit, :update, :edit_password, :update_password]

# sign up page-------------------------------------------------------------
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

  #----------for edit first_name/last_name/email------------------------------
  def edit
    @user = current_user

  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Updated."
      redirect_to home_path
    else
      render :edit
    end
  end

  #------------for change password -------------------------------------------

  def edit_password
    @user = current_user
  end

  def update_password

    @current_password = params[:current_password]
    @new_password = params[:new_password]
    @password_confirmation = params[:password_confirmation]

    if current_user.authenticate(@current_password)
      # puts '---------------------------------you entered the correct password'
      if @new_password == @current_password
        # puts '--------------------------please enter a NEW password!'
        flash[:alert] = "The new password must be different from current password."
        render :edit_password
      else
          if @new_password == @password_confirmation
            # puts '---------------------------------matched!'
                if current_user.update(password: @new_password)
                  # puts '-----------------update completed!'
                  flash[:notice] = "Update completed, thank you."
                  redirect_to home_path
                else
                  # puts '------------------update failed!'
                  render :edit_password
                end
          else
            # puts '---------------------------------not matched!'
            flash[:alert] = "Your new password must match the password confirmation."
            render :edit_password
          end
      end
    else
      # puts '-------------------------------This is not your current password.'
      # puts 'enter current password: ' + @current_password
      # puts 'new password: ' + @new_password
      # puts 'new passwordconfirmation: ' + @password_confirmation
      flash[:alert] = "Please enter the correct current password."
      render :edit_password
    end

  end

  def show
    @user = User.find params[:id]
  end

  def index
  if user_signed_in? && current_user.longitude
    users = User.near([current_user.latitude, current_user.longitude], 5)
    @hash = Gmaps4rails.build_markers(users) do |user, marker| 
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.full_name
    end
  end
end


private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :address,
      :password,
      :password_confirmation
    )
  end

end
