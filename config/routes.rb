# frozen_string_literal: true

Rails.application.routes.draw do
  resources :projects
  resources :tags
  resources :tasks do
    post :toggle
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  root "projects#index"
end
