Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'api/v1/passwords'
  }

  namespace :api do
    namespace :v1 do
      put 'users/update', to: 'users#update'
      put 'users/change-password', to: 'users#change_password'

      post 'password/forgot', to: 'passwords#create'
      put 'password/reset', to: 'passwords#update'

      get 'user_ciphers', to: 'user_ciphers#index'
      post 'user_ciphers/create', to: 'user_ciphers#create'

    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
