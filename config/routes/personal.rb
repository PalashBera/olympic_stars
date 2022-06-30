# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :personal do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    resources :teachers, concerns: :change_loggable do
      resources :teacher_payments, except: :destroy, concerns: :change_loggable
      resources :work_logs, except: :show, concerns: :change_loggable
    end
  end
end
