# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :master do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    resources :client_types, except: :show, concerns: :change_loggable
    resources :fees, except: :show, concerns: :change_loggable
    resources :payment_methods, except: :show, concerns: :change_loggable
    resources :payment_types, except: :show, concerns: :change_loggable
  end
end
