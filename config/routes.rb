Rails.application.routes.draw do

  root to: 'home#index'

  resources :mailing_list_emails, only: [:create]
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"


  resources :users, only: [:new, :create]

  namespace :borrower do
    resources :users, only: [:new, :create, :show]
  end
end
