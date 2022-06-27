# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :coaching do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    resources :students,                    concerns: :change_loggable
    resources :client_types, except: :show, concerns: :change_loggable
    resources :courses,      except: :show, concerns: :change_loggable

    resources :groups, concerns: :change_loggable do
      resources :subscribers, except: %i[show edit update]
      resources :attendances, only: %i[index create destroy]
    end
  end
end
