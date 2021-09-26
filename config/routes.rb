Rails.application.routes.draw do
  root 'sessions#login'
  resource :users

  resources :jobs, only: [:index, :show]
  resources :job_applications, only: [:create, :show]

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
