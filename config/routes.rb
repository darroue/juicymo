# frozen_string_literal: true

Rails.application.routes.draw do
  resources :projects
  resources :tags
  resources :tasks do
    collection do
      match :index, via: %i(get patch)
    end
    post :toggle
  end
  match :search, controller: :search, via: %i(get post)

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  root "tasks#index"
end
