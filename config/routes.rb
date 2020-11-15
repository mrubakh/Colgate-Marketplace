Rails.application.routes.draw do
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :items, only: [:index, :show, :create, :new]
    devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
    resources :users, :only=>[:show, :edit, :update]
    root to: "items#index"
    
    get '/search' => 'items#search', :as => 'search_item'
    post '/users/:id/edit' => 'users#update', :as => 'update_user'
    end
