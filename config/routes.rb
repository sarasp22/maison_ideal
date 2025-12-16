Rails.application.routes.draw do
  get 'profiles/show'
  get 'pages/about'
  get 'pages/blog'
  get 'pages/faq'
  get 'pages/contact'
  devise_for :users

  root "apartments#index"

  get "about", to: "pages#about"
  get "blog", to: "pages#blog"
  get "faq", to: "pages#faq"
  get "contact", to: "pages#contact"

get "profile", to: "profiles#show", as: "profile"
patch "profile", to: "profiles#update"

get "my_bookings", to: "bookings#my_bookings", as: :my_bookings
get "my_apartments", to: "apartments#my_apartments", as: :my_apartments


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
