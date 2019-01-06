Rails.application.routes.draw do

  root 'static#home'


  resources :appointments

  resources :patients, except: :index do
    resources :appointments
  end

  resources :doctors do
    resources :appointments
  end


  get '/login' => 'sessions#new'
  post '/sessions/create' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/about' => 'static#about'

  get '/auth/github/callback' => 'sessions#create'
  get 'auth/failure' => 'sessions#new'


end
