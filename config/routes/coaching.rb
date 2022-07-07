# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :coaching do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    concern :exportable do
      get :export, on: :collection
    end

    concern :importable do
      post :import, on: :collection
    end

    resources :client_types, concerns: %i[exportable importable change_loggable]
    resources :courses,      concerns: %i[exportable importable change_loggable]

    resources :groups, concerns: %i[exportable importable change_loggable] do
      resources :subscribers, except: %i[show edit update],   concerns: :exportable
      resources :attendances, only: %i[index create destroy], concerns: :exportable
    end

    resources :students, concerns: %i[exportable importable change_loggable] do
      resources :student_payments, except: :destroy, concerns: %i[exportable change_loggable]
    end
  end
end
