# frozen_string_literal: true

class AdminController < ApplicationController
  http_basic_authenticate_with name: 'raging', password: 'tortoise'

  def landing; end

  def dashboard; end
end
