# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :coaching do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    concern :exportable do
      get :export, on: :collection
    end

    resources :client_types, concerns: %i[exportable change_loggable]
    resources :courses,      concerns: :change_loggable

    resources :groups, concerns: :change_loggable do
      resources :subscribers, except: %i[show edit update]
      resources :attendances, only: %i[index create destroy]
    end

    resources :students, concerns: :change_loggable do
      resources :student_payments, except: :destroy, concerns: :change_loggable
    end
  end
end
