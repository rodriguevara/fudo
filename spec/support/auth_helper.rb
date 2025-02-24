module AuthHelper
  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.credentials.jwt_secret_key)
  end
end

RSpec.configure do |config|
  config.include AuthHelper, type: :request
end
