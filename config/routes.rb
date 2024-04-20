Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    resources :items, only: [:index, :show]
    get  '/customers/my_page' => 'customers#show'
    get  '/customers/information/edit' => 'customers#edit'
    patch  '/customers/information' => 'customers#update'
    get  '/customers/unsubscribe' => 'customers#unsubscribe'
    patch  '/customers/withdraw' => 'customers#withdraw'

    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete "/cart_items/destroy_all" => "cart_items#destroy_all"

    get "/orders/thanks" => "orders#thanks"
    resources :orders, only: [:new, :create, :index, :show]
    post "/orders/confirm" => "orders#confirm"

    resources :addresses, only: [:index, :show, :edit, :create, :update, :destroy]
  end

  scope module: :admin do
    get "/admin" => "homes#top"
  end

  namespace :admin do
    resources :items, only: [:new, :index, :show, :edit, :create, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :customers, only: [:index, :edit, :show, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
