Rails.application.routes.draw do
  get 'dashboard/index'
  # get 'static_pages/home'
  # auth
  root "static_pages#home"
  post "sign_up", to: "users#create"
  get "sign_up", to: "users#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"

  resources :posts, except: [:show] do
    resources :comments, only: [:create]
  end
  post "post_likes", to: "likes#toggle"
  
end
