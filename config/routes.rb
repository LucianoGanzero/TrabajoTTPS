Rails.application.routes.draw do
  root "welcome#index"
  resource :session
  resources :passwords, param: :token
  # Shopping cart guide: https://www.youtube.com/watch?v=SPokmOwiM7E
  get "cart/:id", to: "cart#show", as: "cart"
  post "cart/add"
  post "cart/remove"
  post "cart/confirm", to: "cart#confirm", as: "confirm_cart"


  resources :shop_products, only: [ :index, :show ]
  resources :dashboard, only: [ :index ]
  get "store_management", to: "dashboard#store_management", as: :store_management
  resources :size_stocks, except: [ :index, :new,:show, :edit, :update, :destroy ] do
    member do
      patch :increment
      patch :decrement
    end
  end
  #resources :roles
  resources :users
  resources :sales, except: [ :edit, :update ] do
    resources :product_solds, only: [ :new, :create ]
    get :search_products, on: :collection
    patch "assign_salesman", on: :member
  end
  resources :product_solds, except: [ :index, :show, :edit, :update, :destroy ]
  resources :colors, except: [ :index ]
  resources :sizes, except: [ :index ]
  resources :categories, except: [ :index ]
  resources :products, except: [ :destroy ] do
    resources :categories, only: [ :update ] do
      patch :disassociate, on: :member
    end
    resources :colors, only: [ :update ] do
      patch :disassociate, on: :member
    end
    member do
      patch :deactivate
      patch :activate
    end
  end
  match '*path', to: 'application#not_found', via: :all
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
