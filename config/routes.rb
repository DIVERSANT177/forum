Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  resources :questions do
      resources :answers, except: [ :new, :show ]
  end

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
      end
      resource :questions do
        get :index, on: :collection
        get :show, on: :collection
      end
    end
  end

  root to: "questions#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  #
end
