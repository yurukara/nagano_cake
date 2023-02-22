Rails.application.routes.draw do
  devise_for :members, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    get '/' => 'homes#top'
    resources :items, only: [:index,:new,:create,:show,:edit,:update]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :members, only: [:index,:show,:edit,:update]
    resources :orders, only: [:show,:update] do
      resources :order_details, only: [:update]
    end
  end
  
  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    resources :items, only: [:index,:show]
    get 'members/my_page' => 'members#show',as:'my_page'
    get 'members/information/edit' => 'members#edit',as:'members_edit'
    patch 'members/information' => 'members#update',as:'members_update'
    get 'members/confirm' => 'members#confirm',as:'members_confirm'
    patch 'members/withdraw' => 'members#withdraw',as:'members_withdraw'
    resources :cart_items, only: [:index,:update,:create,:destroy]
    delete 'cart_items' => 'cart_items#destroy_all',as:'destroy_all'
    get 'orders/thanks' => 'orders#thanks',as:"orders_thanks"
    resources :orders, only: [:new,:create,:index,:show]
    post 'orders/confirm' => 'orders#confirm',as:"orders_confirm"

    resources :addresses, only: [:index,:edit,:create,:update,:destroy]
  end

  get '/searches' => 'searches#search', as:'search'
 end