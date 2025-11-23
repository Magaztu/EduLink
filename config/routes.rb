Rails.application.routes.draw do
  root "static_pages#home"
  get 'privacy', to: 'static_pages#privacy'
  
  get 'login', to: 'auth#login'
  post 'login', to: 'auth#create_session'
  get 'register', to: 'auth#register'
  post 'register', to: 'auth#create_user'
  delete 'logout', to: 'auth#destroy_session'

  resource :password_reset, only: [:new, :create, :edit, :update] do
    collection do
      get 'verify'
      post 'check_verification'
    end
  end

  resources :servicios do
    resources :slot_horarios, only: [:create]
  end
  
  resources :slot_horarios, only: [:destroy] do
    resources :reservas, only: [:new, :create]
  end
  
  get 'historial', to: 'historial#index'
  
  resources :reservas, only: [] do
    resources :pagos, only: [:new, :create]
    resource :cancelacion, only: [:create], controller: 'cancelaciones'
  end

  # Admin Route
  get 'admin', to: 'admin#index'

  get "up" => "rails/health#show", as: :rails_health_check
end
