Rails.application.routes.draw do


  
  resources :comments
  devise_for :users
  root 'pages#home'
  
  resources :games do
    resources :comments
  end
end
