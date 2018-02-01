class Api::ApplicationController < ApplicationController
skip_before_action :verify_authenticity_token

rescue_from StandardError, with: :standard_error # more broad (internal error)
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

def not_found # for unmatched routes/paths
  render(
    json: {
      errors:[{
          type: 'NotFound'
      }]
    },
    status: :not_found
  )
end


  private

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?


  def current_user
     token_type, token = request.headers["AUTHORIZATION"]&.split(" ") || []

     case token_type&.downcase
     when 'api_key'
       @user ||= User.find_by(api_key: token)
     when 'jwt'
       begin
         payload = JWT.decode(
           token,
           Rails.application.secrets.secret_key_base
         )&.first
         @user ||= User.find(payload["id"])
       rescue JWT::DecodeError => error
         nil
       end
     end
   end
  helper_method :current_user


  def api_key
    request.headers['AUTHORIZATION']
  end

  def authenticate_user!
    # head :unauthorized unless current_user.present?
    head :unauthorized unless user_signed_in?
  end

  protected

  def record_not_found(error)
    render(
      json: {
        errors: [{
          type: error.class.to_s,
          message: error.message
          }]
      },
      status: :not_found
    )
  end

  def standard_error(error)
    render(
      json: {
        errors: [{
          type: error.class.to_s,
          message: error.message
        }]
      },
      status: :internal_server_error
    )
  end

  def record_invalid(error)
    record = error.record
    errors = record.errors.map do |field, message|
      {
        type: error.class.to_s,
        record_type: record.class.to_s,
        field: field,
        message: message
      }
    end
    render(
      json: {
        errors: errors
      },
      status: :unprocessable_entity
    )
  end


end
