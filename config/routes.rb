Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      get '/merchants/most_items', to: 'merchants#most_items'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], module: :merchants
      end
      get '/items/find_all', to: 'items#find_all'
      resources :items, only: [:index, :show] do
        resources :merchant, only: [:index], module: :items
      end
      namespace :revenue do
        resources :merchants, only: [:index, :show]
        resources :items, only: [:index]
      end
    end
  end
end
