class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    begin
      @decoded = jwt_decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.credentials.jwt_secret_key)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, Rails.application.credentials.jwt_secret_key)[0]
    HashWithIndifferentAccess.new decoded
  end

  def current_user
    @current_user
  end
end
