# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :coaching do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    resources :students, concerns: :change_loggable
  end
end
