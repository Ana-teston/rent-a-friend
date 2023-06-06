Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :friends, only: [:index, :new, :create, :show] do
    resources :bookings, only: [:create, :edit, :update]
  end
  resources :bookings, only: [:index, :destroy]
end
