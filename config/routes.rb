Rails.application.routes.draw do
  get 'login', to: 'sessions#new'

  resources 'sessions', only: :create
end
