Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  root to: 'dashboard#index'
  get '/dashboard', to: 'dashboard#show', as: :dashboard

  get '/trips-dashboard', to: 'trips#dashboard', as: :trips_dashboard
  get '/bike-shop', to: 'accessories#index', as: :bike_shop

  get '/cart', to: 'carts#show', as: :cart
  patch '/carts', to: 'carts#update'
  delete '/cart/:id', to: 'carts#destroy', as: :cart_destroy

  resources :stations, except: [:show]
  get '/station/:name', to: 'stations#show'
  get '/stations-dashboard', to: 'stations#dashboard', as: :stations_dashboard

  resources :carts, except: [:index]

  resources :trips, only: [:show, :index]
  resources :accessories, only: [:show, :index]


  resources :users

  resources :orders

  namespace :admin do
    get '/bike-shop/new', to: 'accessories#new', as: :bike_shop_accessory_new
    post '/bike-shop/new', to: 'accessories#create', as: :bike_shop_accessories
    get '/bike-shop', to: 'accessories#index', as: :bike_shop
  end

  namespace :admin do
    resources :trips
    resources :stations
    resources :orders
    resources :accessories, except: [:index]
    get '/dashboard', to: 'orders#index', as: :dashboard
  end

end
