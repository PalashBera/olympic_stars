# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users

  root "home#index"
  get  "/dashboard", to: "home#dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
