Rails.application.routes.draw do
  root to: 'home#index'

  resources :projects, only: [:index, :show]
  resource :cart, only: [:show]
  resources :cart_projects, only: [:create, :destroy, :update]
  resources :mailing_list_emails, only: [:create]
  resources :borrowers, only: [:new, :create]

  resources :users, only: [:new, :create] do
    resources :orders, only: [:new, :index, :create, :show]
    get "/orders/:order_id/thanks", to: "orders#thanks", as: "thanks"
  end

  namespace :borrower do
    resources :users, only: [:new, :create, :show]
    resources :projects, only: [:new, :create, :index, :update]
    resources :orders, only: [:index, :show, :update]
    resources :comments, only: [:create]
  end

  namespace :admin do
  end

  get "orders/login", to: "orders#checkout_login", as: "checkout_login"
  post "orders/login", to: "orders#checkout_user", as: "checkout_user"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/lend", to: "projects#index"

  get "/:name", to: "categories#show"
end
