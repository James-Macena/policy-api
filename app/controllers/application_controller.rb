# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :validate_token

  def auth_token
    request.headers['Authorization']&.gsub('Bearer ', '')
  end

  private

  def validate_token
    JWT.decode(
      auth_token,
      ENV.fetch('JWT_SECRET_KEY'), true,
      { algorithm: ENV.fetch('JWT_ALGORITHM') }
    )
  rescue JWT::VerificationError, JWT::DecodeError
    render status: 401, body: 'Invalid token'
  end
end
