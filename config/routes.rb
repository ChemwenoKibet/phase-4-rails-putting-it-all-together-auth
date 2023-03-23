Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :recipes, only: [:index, :create]
  #POST /signup
  post '/signup', to: 'users#create'
  #DELETE 
  delete '/logout', to: 'sessions#destroy'
  #GET /me
  get '/me', to: 'users#show'
  #POST /Login
  post "/login", to: "sessions#create"
  #POST /recipes
  post '/recipes', to: 'recipes#create'
end
