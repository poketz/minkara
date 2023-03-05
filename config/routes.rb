Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/users/sign_out' => 'users/sessions#destroy'
  end

  root to: 'homes#top'
  get 'about' => 'homes#about'

  resources :users, except: [:new, :index, :destroy] do
    collection do
      get '/infomation' => 'users#show_info'
      patch '/infomation' => 'users#update'
      get 'confirm'
      patch 'withdraw'
      get 'search'
    end
    resources :requests, only: [:create, :destroy]
    resource :follows, only: [:create, :destroy]
    resources :notifications, only: [:index, :create, :destroy] do
      delete 'destroy_all', on: :collection
    end
    # forumにネストさせた方がいいかも？
    resources :forum_favorites, only: [:create, :destroy]
  end
  resources :posts, except: [:edit, :index] do
    get 'search', on: :collection
    resources :post_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  resources :forums, only: [:index, :create, :show] do
    resources :forum_comments, only: [:create, :destroy]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
