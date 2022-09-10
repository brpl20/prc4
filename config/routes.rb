Rails.application.routes.draw do
  get 'office_types/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'pages/index'
  get 'pages/dashboard'
  get 'pages/help'
  get 'pages/plans'

  get 'clients/modal/recommendation_search', to: 'clients#search'
  get 'clients/modal/representative_search', to: 'clients#representative_search'
  get 'clients/modal/representative_accountant_search', to: 'clients#representative_accountant_search'

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
  resources :perd_launches, except: %i[show]
  resources :work_updates, except: %i[show]

  resources :client do
    resources :file_uploads, only: %i[new create destroy]
  end

  delete '/work/:work_id/file_uploads/:id', to: 'file_uploads#destroy_file_work', as: :delete_archive_file_work
end
