Rails.application.routes.draw do
  devise_for :users
  root 'public#index'

  resources :phrases
  resources :products
  resources :categories
  resources :caracteristiques
  resources :sites
  resources :users

  get 'dashboard' => 'dashboard#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
