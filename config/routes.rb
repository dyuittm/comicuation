Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: "public/homes#top"
  get '/about' => 'public/homes#about'
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
