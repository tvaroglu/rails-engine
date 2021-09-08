Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], module: :merchants
      end
      get '/items/find_all', to: 'items#find_all'
      resources :items do
        resources :merchant, only: [:index], module: :items
      end
    end
  end
end
