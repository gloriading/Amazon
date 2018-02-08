class CallbacksController < ApplicationController
  def index
    oauth_data = request.env['omniauth.auth']
    # render json: oauth_data

    user = User.find_by_oauth(oauth_data)
    user ||= User.create_from_oauth(oauth_data)
    if user.valid?
      session[:user_id] = user.id
      redirect_to home_path, notice: "Thanks for signing in with Github"
    else
      redirect_to home_path, alert: user.errors.full_messages.join(", ")
    end
  end

end
