# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :ledgers do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    concern :exportable do
      get :export, on: :collection
    end

    resources :incomes,  only: :index, concerns: %i[exportable change_loggable]
    resources :expenses, only: :index, concerns: %i[exportable change_loggable]
  end
end
