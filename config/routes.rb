Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'pages/index'
  get 'pages/dashboard'
  get 'pages/help'
  get 'pages/plans'
  get 'profile', to: 'user_profile#edit'
  patch 'profile', to: 'user_profile#update'

  root to: "pages#dashboard"

  devise_for :users
  resources :jobs
  resources :works
  resources :clients
  resources :people
  resources :lawyers
  #do get 'receipt' end
  resources :offices
  resources :attendances
  resources :finances
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
