Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :comments, only: [:create]
  end

  resources :likes, only: [:create, :destroy]
  
  resources :profiles, only: [:show, :new, :edit, :create, :update]
  root 'welcome#index'
end
  