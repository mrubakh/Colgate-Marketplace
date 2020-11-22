Rails.application.routes.draw do
 get 'static_pages/about'
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :items, only: [:index, :show, :create, :new]
    devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
    resources :users, :only=>[:show, :edit, :update]
    root to: "items#index"
    
    get '/search' => 'items#search', :as => 'search_item'
    get 'send_interest_email', to: 'items#send_interest_email'
    post '/users/:id/edit' => 'users#update', :as => 'update_user'
end
