Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :comments, only: [:create, :edit, :update, :destroy]

  resources :captions do
    resources :comments, only: [:create]
  end

  resources :captions, except: [:index]
  root "home#index"
  get '/captions', to: 'captions#index', as: 'user_root'
end
