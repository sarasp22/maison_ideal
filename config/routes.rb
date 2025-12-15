Rails.application.routes.draw do
  devise_for :users

  root "apartments#index"

  resources :apartments do
    resources :reviews, only: [:create]
    resources :bookings, only: [:new, :create, :index, :show]
    resources :photos, only: [:create, :destroy]
  end

  resources :bookings, only: [:index, :show] do
    resources :payments, only: [:new, :create]
  end

  resources :users, only: [:show, :edit, :update]

end
