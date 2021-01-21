Rails.application.routes.draw do
  
  resources :tasks
  resources :projects
  devise_for :users
  root to: "tweets#index"
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
end
