# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :transaction do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    resources :payment_methods, except: :show, concerns: :change_loggable
    resources :payment_types, except: :show, concerns: :change_loggable
  end
end
