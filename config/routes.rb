Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :lawyers
  get 'pages/index'
  get 'pages/dashboard'
  get 'pages/help'
  get 'pages/plans'
  root to: "pages#dashboard"
  resources :jobs
  resources :works
  devise_for :users
  resources :clients do
    get 'receipt'
  end
  resources :offices
  resources :attendances
  resources :finances
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
