# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admin/landing'
  get 'admin/dashboard'

  root to: 'admin/landing'
end
