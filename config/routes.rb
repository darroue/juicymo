# frozen_string_literal: true

Rails.application.routes.draw do
  resources :projects
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  root "projects#index"
end
