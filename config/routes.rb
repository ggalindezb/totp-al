# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admin/verify'
  post 'admin/authenticate'
  get 'admin/dashboard'

  root to: 'admin#verify'
end
