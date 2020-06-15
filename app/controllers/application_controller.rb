# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def totp
    @rotp = ROTP::TOTP.new(Rails.application.credentials.rotp_token, issuer: 'Admin')
  end

  def verify_mfa
    raise StandardError unless session[:user_id].present?
  end
end
