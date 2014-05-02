Rails.application.routes.draw do
  root to: 'subs#index'
  resources :users
  resource :session, only: [:create, :new, :destroy]
  resources :subs
  resources :links do
    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy]
end
