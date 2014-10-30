Rails.application.routes.draw do
  root to: 'cats#index'
  get '/learn_more', to: "static_pages#about", as: "about"
  get 'cats/requests_cats', to: 'cats#request_cats', as: 'cat_request_cats'
  resources :cats do
  	resources :cat_rental_requests, only: [:new, :create]
  end
  
  resources :cat_rental_requests, only: [:destroy] do
    get 'approve'
    get 'deny'
  end
  
  resources :users, only: [:new, :create, :index]
  resources :sessions, only: [:create, :destroy, :new, :index]
end
