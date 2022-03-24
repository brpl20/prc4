Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'pages/index'
  get 'pages/dashboard'
  get 'pages/help'
  get 'pages/plans'

  get 'pages/clt_covid'
  post 'pages/clt_covid_s3'

  get 'clients/new_rep/:id', to: 'clients#new_rep', as: :new_rep
  # criacao da rota

  root to: "pages#dashboard"

  devise_for :users

  resources :jobs
  resources :works
  resources :clients
  resources :people
  resources :lawyers
  resources :user_profile, as: 'profile'
  resources :offices
  resources :attendances
  resources :finances
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
