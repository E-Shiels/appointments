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
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/about' => 'static#about'

  root 'static#home'

end
