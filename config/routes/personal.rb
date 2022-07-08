# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :personal do
    concern :change_loggable do
      get :change_logs, on: :member
    end

    concern :exportable do
      get :export, on: :collection
    end

    concern :importable do
      post :import, on: :collection
    end

    resources :teachers, concerns: %i[exportable importable change_loggable] do
      resources :teacher_payments, except: :destroy, concerns: %i[exportable importable change_loggable]
      resources :work_logs,        except: :show,    concerns: %i[exportable importable change_loggable]
    end
  end
end
