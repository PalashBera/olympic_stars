# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :master do
    resources :client_types, except: :show
  end
end
