Rails.application.routes.draw do
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :items, only: [:index, :show, :create, :new]
    devise_for :users
    resources :users, :only=>[:show]
    root to: "items#index"
    
    get '/search' => 'items#search', :as => 'search_item'
    get 'send_interest_email', to: 'items#send_interest_email'
end
