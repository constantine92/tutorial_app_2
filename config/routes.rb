Rails.application.routes.draw do

  get '/about', to: "pages#about"
  get '/contact', to: "pages#contact"
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"
  get 'users/show'
  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  resources :users
  
end
