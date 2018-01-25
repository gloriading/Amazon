class SessionsController < ApplicationController
  def new # show a sign-in page , put a link for nav
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Thank you for sign in!'
      user_ip = request.remote_ip
      Location.create(ip: user_ip, user: user)
      redirect_to home_path
    else
      flash.now[:alert] = 'Wrong email or password!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil # which means the user is no longer signed in
    redirect_to home_path, notice: 'Signed Out! See ya!!'
  end


private
  def session_params
    params.require(:session).permit(:email, :password)
  end

end
