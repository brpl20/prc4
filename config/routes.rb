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
  get 'clients/generate_doc/:id', to: 'clients#generate_docs_show', as: :generate_docs

  root to: 'pages#dashboard'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_for :customers, controllers: {
    sessions: 'customers/sessions'
  }

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
  get '/area_cliente/:client_id/trabalhos', to: 'site/show_works#show', as: :client_works_show
  get '/area_cliente', to: 'site/show_works#index', as: :site_index
end
