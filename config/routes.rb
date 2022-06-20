Rails.application.routes.draw do
  get 'office_types/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'pages/index'
  get 'pages/dashboard'
  get 'pages/help'
  get 'pages/plans'

  get 'clients/hunts', to: 'clients#hunt'

  root to: 'pages#dashboard'

  devise_for :users

  resources :clients
  resources :jobs
  resources :works
  resources :people
  resources :lawyers
  resources :user_profile, as: 'profile'
  resources :offices
  resources :attendances
  resources :finances
  resources :customer_types
  resources :office_types

  resources :client do
    resources :file_uploads, only: %i[new create destroy]
  end
end
