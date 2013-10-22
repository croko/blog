Blog::Application.routes.draw do
  resources :articles

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:edit, :update, :show]

  root to: 'articles#index'

end
