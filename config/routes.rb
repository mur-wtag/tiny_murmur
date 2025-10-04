# frozen_string_literal: true

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users, controller: "users", only: [ :show ] + Clearance.configuration.user_actions
  get "/me", to: "users#me", as: :me

  root "murmurs#index"
  resources :murmurs, only: %i[index new create edit update destroy] do
    resources :comments, only: %i[new create edit update destroy]
  end

  namespace :api, defaults: { format: :json } do
    resources :murmurs, only: [ :index, :show, :create, :destroy ] do
      resources :likes, only: [ :create, :destroy ]
    end

    resources :users, only: [ :show ], path: :me

    resources :users, only: [] do
      resource :follows, only: [ :create, :destroy ]
    end
  end
end
