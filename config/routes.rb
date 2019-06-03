Rails.application.routes.draw do
  get 'login', to: 'sessions#new'

  resources :sessions, only: :create

  resources :repos, only: :index do
    resources :issues, only: :index
  end
end
