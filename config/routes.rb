# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create] do
        get 'my_basket', on: :collection
      end
      resources :frames, only: %i[show index]
      resources :lenses, only: %i[show index]
      resources :glasses, only: %i[create]
      post :login, to: 'sessions#create'

      # Admin APIs
      scope module: :admin do
        resources :frames, only: %i[create update destroy]
        resources :lenses, only: %i[create update destroy]
      end
    end
  end
end
