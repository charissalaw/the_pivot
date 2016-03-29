Rails.application.routes.draw do
  get 'country/show'

  namespace :borrower do
  get 'loans/index'
  end

  namespace :borrower do
  get 'loans/show'
  end

  root to: 'home#index'

  get "/lend", to: "projects#index", as: "projects"
  resource :cart, only: [:show]
  resources :cart_projects, only: [:create, :destroy, :update]
  resources :mailing_list_emails, only: [:create]
  resources :borrowers, only: [:new, :create]
  resources :categories, param: :slug, only: [:show]
  resources :countries, param: :slug, only: [:show]

  resources :users, only: [:new, :create, :show, :update] do
    resources :orders, only: [:new, :index, :create, :show]
    get "/orders/:order_id/thanks", to: "orders#thanks", as: "thanks"
  end

  namespace :borrower do
    resources :users, only: [:new, :create, :show] do
      resources :projects, only: [:new, :create, :index, :update, :show]
      resources :orders, only: [:index, :show, :update]
      resources :loans, only: [:index, :show, :update]
      resources :repayments, only: [:create, :update, :show]
      resources :comments, only: [:create]
    end
  end

  namespace :admin do
    resources :users, only: [:show]
    resources :borrowers, only: [:index, :show]
    resources :projects, only: [:index, :update, :create]
  end

  get "loans/login", to: "orders#checkout_login", as: "checkout_login"
  post "loans/login", to: "orders#checkout_user", as: "checkout_user"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/lend", to: "projects#index"

  resource :projects, as: :project, path: ":project", only: [:show]
end
