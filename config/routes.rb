Rails.application.routes.draw do
  get 'reviews/new'
  devise_for :users

  root to: "vinyls#home"
  get "up" => "rails/health#show", as: :rails_health_check


  resources :vinyls do
    resources :sales, only: %i[new create]
  end

  get 'genre/:genre', to: 'vinyls#genre', as: 'genre'

  resources :sales, only: [:index] do
    resources :reviews
  end
end
