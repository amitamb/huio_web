Rails.application.routes.draw do

  get 'history/index', as: :history
  get 'history/show'
  # import_controller
  get 'import/index', as: :import
  post 'import/process_import', as: :process_import

  resources :users

  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
