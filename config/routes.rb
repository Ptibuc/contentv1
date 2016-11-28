Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/boss', as: 'rails_admin'
  #devise_for :users
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations'
  }
  root 'public#index'

  resources :phrases
  resources :products
  resources :categories
  resources :caracteristiques
  resources :sites
  resources :users

  get '/dashboard' => 'dashboard#index'
  get '/select_site/:site' => 'dashboard#select_site'
  get '/change_site' => 'dashboard#change_site'

  get '/test_presta' => 'prestashop#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
