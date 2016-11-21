Rails.application.routes.draw do
  get 'pages/index'

  get 'pages/about'

  get 'pages/contact'

  get 'users/show'

  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
  
end
