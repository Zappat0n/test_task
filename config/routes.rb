Rails.application.routes.draw do
  root 'sessions#login'

  resource :users, only: [:new, :create]
  resources :jobs, only: [:index, :show]
  resources :job_applications, only: [:create]

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
