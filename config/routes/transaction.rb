# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :transaction do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    concern :exportable do
      get :export, on: :collection
    end

    concern :importable do
      post :import, on: :collection
    end

    resources :cash_books,      concerns: %i[exportable change_loggable]
    resources :payment_methods, concerns: %i[exportable importable change_loggable]
    resources :payment_types,   concerns: %i[exportable importable change_loggable]
  end
end
