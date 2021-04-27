Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords'
  }
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlroot to: 'homes#top'
  root to: 'public/homes#top'
  get "/about" =>"public/homes#about"

  devise_scope :customers do
  get "/customers/my_page" =>"public/customers#show"
  end

  get "/customers/edit" =>"public/customers#edit"
  patch "/customers" =>"public/customers#update"
  get "/customers/unsubscribe" =>"public/customers#unsubscribe"
  patch "/customers/withdraw" =>"public/customers#withdraw"
  delete "/cart_items/destroy_all" =>"public/cart_items#destroy_all"
  patch "/cart_items/:id" =>"public/cart_items#update"
  post "/orders/confirm" =>"public/orders#confirm"
  get "/orders/complete" =>"public/orders#complete"
  patch "/addresses/:id" =>"public/addresses#update"

  scope module: 'public' do
    resources :items, only: [:index, :show] do
      resources :cart_items, only: [:create]
    end
  end

  scope module: 'public' do
    resources :cart_items, only: [:index, :destroy]
  end

  scope module: 'public' do
    resources :orders, only: [:new, :index, :show, :create]
  end

  scope module: 'public' do
    resources :addresses, only: [:index, :edit, :create, :destroy]
  end

  namespace :admin do
    get "/" =>"homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit]
    patch "items/:id" =>"items#update"
    resources :genres, only: [:index, :create, :edit]
    patch "genres/:id" =>"genres#update"
    resources :customers, only: [:index, :show, :edit]
    patch "customers/:id" =>"customers#update"
    resources :orders, only: [:show]
    patch "orders/:id" =>"orders#update"
    patch "order_details/:id" =>"order_details#update"
  end

end
