Rails.application.routes.draw do

  resources :appointments do
    resources :patients, except: :index
    resources :doctors
  end

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

  root 'static#home'

end
