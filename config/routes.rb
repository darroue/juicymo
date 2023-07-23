# frozen_string_literal: true

Rails.application.routes.draw do
  resources :projects do
    resources :tasks
  end
  resources :tags

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  root "projects#index"
end
