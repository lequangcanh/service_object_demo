Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :histories, only: %i(new create index)
end
