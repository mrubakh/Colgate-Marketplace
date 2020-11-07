Rails.application.routes.draw do
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :items, only: [:index, :show, :create, :new]
    devise_for :users
    root "items#index"

end
