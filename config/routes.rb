Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    resources :users, only:[:show, :index, :edit, :update]
    resources :posts, only:[:show, :index, :edit, :update, :destroy]
    get '/post/hashtag/:name' => 'posts#hashtag'
    get '/post/hashtag' => 'posts#hashtag'
  end

  root to: "public/homes#top"
  get '/about' => 'public/homes#about'

  scope module: :public do
    resources :users, only:[:show, :index, :edit, :update]
    resources :posts
    get '/post/hashtag/:name' => 'posts#hashtag'
    get '/post/hashtag' => 'posts#hashtag'
    resources :groups do
      resource :group_users, only: [:create, :destroy]
    end
  end

  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
