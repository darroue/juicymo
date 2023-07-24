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

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  root "projects#index"
end
