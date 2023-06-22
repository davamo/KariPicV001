Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :comments, only: [:create, :edit, :update, :destroy]

  resources :captions do
    resources :comments, only: [:create]
  end

  resources :captions, except: [:index] do
    resources :comments, only: [:create]
    member do
      patch 'update_caption' # Ruta personalizada para actualizar una leyenda específica
    end
  end


  root "home#index"
  get '/captions', to: 'captions#index', as: 'user_root'
end
