Rails.application.routes.draw do
  root 'dashboards#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
end
