Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  root "sessions#home", page: 'shared/home'
  # Session based authentication
  resource :session, only: [:create]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
end
