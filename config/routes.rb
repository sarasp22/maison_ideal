Rails.application.routes.draw do
  devise_for :users

  root "apartments#index"

  get "about", to: "pages#about"
  get "blog", to: "pages#blog"
  get "faq", to: "pages#faq"
  get "contact", to: "pages#contact"

  get "profile", to: "profiles#show", as: :profile
  patch "profile", to: "profiles#update"

  get "my_apartments", to: "apartments#my_apartments", as: :my_apartments

  resources :apartments do
    resources :bookings, only: [:create]
    resources :reviews, only: [:create]
    resources :photos, only: [:create, :destroy]
  end

  resources :bookings, only: [:show, :create, :edit, :update, :destroy] do
    member do
    patch :accept
    patch :reject
  end
    resources :payments, only: [:new, :create]
  end

  resources :users, only: [:show, :edit, :update]
end
