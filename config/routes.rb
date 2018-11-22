Rails.application.routes.draw do
  resources :appointments do
    resources :patients
    resources :doctors
  end

  resources :patients do
    resources :appointments
  end

  resources :doctors do
    resources :appointments
  end

end
