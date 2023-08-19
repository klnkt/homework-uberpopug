Rails.application.routes.draw do
  root to: 'tasks#index'

  resources :tasks do
    patch :complete, on: :member
    post :reassign_all, on: :collection
  end

  get 'auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
end
