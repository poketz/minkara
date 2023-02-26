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
    end
    resources :requests, only: [:create, :destroy]
    resources :follows, only: [:create, :destroy]
    resources :notifications, only: [:index, :create, :destroy] do
      delete 'destroy_all', on: :collection
    end
    # forumにネストさせた方がいいかも？
    resources :forum_favorites, only: [:create, :destroy]
  end
  resources :posts, except: [:edit, :index] do
    resources :post_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  resources :forums, only: [:index, :create, :show] do
    resources :forum_comments, only: [:create, :destroy]
  end
  get 'post_seach' => 'seaches#post_seach'
  get 'song_seach' => 'seaches#song_seach'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
