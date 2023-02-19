Rails.application.routes.draw do
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'homes#top'
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
    resources :forum_favorites, only: [:create, :destroy]
  end
  resources :posts, except: [:edit, :index] do
    resources :post_comments, only: [:create, :destroy]
  end
  get 'post_seach' => 'seaches#post_seach'
  get 'song_seach' => 'seaches#song_seach'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
