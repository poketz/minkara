Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/users/sign_out' => 'users/sessions#destroy'
    post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
  end

  root to: 'homes#top'
  get 'about' => 'homes#about'

  resources :users, except: [:new, :index, :destroy] do
    collection do
      get 'confirm'
      patch 'withdraw'
      get 'search'
    end
    resources :requests, only: [:index, :create, :destroy]
    resource :follows, only: [:create, :destroy]
    resources :notifications, only: [:index] do
      patch :read, on: :member
      patch :read_all, on: :collection
    end
  end
  resources :posts, except: [:edit, :index] do
    get 'search', on: :collection
    # get '/autocomplete_song/:song', on: :collection, action: :autocomplete_song
    resources :post_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
