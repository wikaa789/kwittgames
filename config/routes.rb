Rails.application.routes.draw do

  devise_for :users
  root 'pages#home'
  
  resources :games do
    resources :comments
    resources :ratings
  end
end
