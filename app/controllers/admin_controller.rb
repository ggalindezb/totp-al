# frozen_string_literal: true

class AdminController < ApplicationController
  http_basic_authenticate_with name: 'raging', password: 'tortoise'
  before_action :verify_mfa, except: %i[verify authenticate]

  def authenticate
    redirect_to admin_dashboard_path if valid_mfa?
  rescue ROTP::Base32::Base32Error
    redirect_to admin_verify_path
  end

  private

  def valid_mfa?
    session[:user_id] = SecureRandom.uuid if totp.verify(params[:mfa_token])
  end
end
