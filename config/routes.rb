Rails.application.routes.draw do
  resources :cats
  
  resources :cat_rental_requests, only: [:new, :create, :destroy] do
    get 'approve'
    get 'deny'
  end
end
