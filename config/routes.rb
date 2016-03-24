Rails.application.routes.draw do

  root to: 'home#index'

  resources :mailing_list_emails, only: [:create]
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create] do
    resources :orders, only: [:new]
  end

  get "/lend", to: "borrower/users#index"
  namespace :borrower do
    resources :users, only: [:new, :create, :show]
  end

end
