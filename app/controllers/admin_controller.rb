# frozen_string_literal: true

class AdminController < ApplicationController
  http_basic_authenticate_with name: 'raging', password: 'tortoise'
  before_action :verify_mfa, only: :dashboard

  def mfa_qr
    qrcode = RQRCode::QRCode.new(totp.provisioning_uri('test@test.com'))

    svg = qrcode.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6,
      standalone: true
    )

    IO.binwrite('public/github-qrcode.svg', svg.to_s)
  end

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
