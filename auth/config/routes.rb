Rails.application.routes.draw do
  use_doorkeeper
  devise_for :accounts, controllers: {
    registrations: 'accounts/registrations',
    sessions: 'accounts/sessions'
  }

  # Defines the root path route ("/")
  # root "articles#index"
end
