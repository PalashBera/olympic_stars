# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :inventory do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    concern :exportable do
      get :export, on: :collection
    end

    concern :importable do
      post :import, on: :collection
    end

    resources :products, concerns: %i[exportable importable change_loggable]
  end
end
