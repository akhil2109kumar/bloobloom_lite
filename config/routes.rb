# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :frames, only: %i[show index]
      resources :lenses, only: %i[show index]

      post :login, to: 'sessions#create'

      # Admin APIs
      scope module: :admin do
        resources :frames, only: %i[create update destroy]
        resources :lenses, only: %i[create update destroy]
      end
    end
  end
end
