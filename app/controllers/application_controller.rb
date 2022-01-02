class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_errors

  before_action :authorize

  private
  def authorize
    @current_user = User.find_by(id: session[:user_id])
    render json: { errors: ['Invalid username or password'] }, status: :unauthorized unless @current_user
  end

  def render_record_invalid_errors(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
