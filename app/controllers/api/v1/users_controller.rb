class Api::V1::UsersController < Api::ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :find_user, only: [:show, :update, :destroy]

  def show
    render json: @user
  end

  def index
    @users = User.order(created_at: :desc)
    render json: @users
  end

  def create
    user = User.new user_params
    if user.save
      # if the new user has been successfully created,
      # create a jwt token here and render it to the front end
      render json: {
          jwt: encode_token({
            id: user.id,
            first_name: user.first_name,
            last_name: user.last_name,
            full_name: user.full_name,
            email: user.email
            })
        }
    else
      p user.errors.full_messages
      render json: { error: user.errors.full_messages}
    end

  end

  def update
    if @user.update user_params
      render json: @user
    else
      render json: { error: user.errors.full_messages}
    end
  end

  def destroy
    if @user.destroy
      head :ok
    else
      head :bad_request
    end
  end

  private

  def find_user
    @user = User.find params[:id]
  end

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

  def encode_token(payload = {}, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

end
