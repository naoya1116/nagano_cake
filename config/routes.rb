Rails.application.routes.draw do
  devise_for :customers,skip: [:registrations], controllers: {
    sessions: 'devise/customer/sessions',
    passwords: 'devise/customer/passwords'
  }

  devise_for :admin, controllers: {
    sessions: 'devise/admin/sessions',
    passwords: 'devise/admin/passwords'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlroot to: 'homes#top'

  devise_scope :customer do
  get 'customers/sign_up' => 'devise/customer/registrations#new', as: :new_customer_registration
  post 'customers' => 'devise/customer/registrations#create', as: :customer_registration
  end


  root to: 'public/homes#top'
  get "/about" =>"public/homes#about"

  get "/customers/my_page" =>"public/customers#show"

  get "/customers/edit" =>"public/customers#edit"
  patch "/customers" =>"public/customers#update"
  get "/customers/unsubscribe" =>"public/customers#unsubscribe"
  patch "/customers/withdraw" =>"public/customers#withdraw"

  scope module: 'public' do
    resources :items, only: [:index, :show]
  end

  scope module: 'public' do
    resources :cart_items, only: [:index,:create, :destroy]
  end
  delete "/cart_items/destroy_all" =>"public/cart_items#destroy_all"
  patch "/cart_items/:id" =>"public/cart_items#update"

  post "/orders/confirm" =>"public/orders#confirm"
  get "/orders/complete" =>"public/orders#complete"
  scope module: 'public' do
    resources :orders, only: [:new, :index, :show, :create]
  end


  scope module: 'public' do
    resources :addresses, only: [:index, :edit, :create, :destroy]
  end
   patch "/addresses/:id" =>"public/addresses#update"

  namespace :admin do
    get "/" =>"homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit]
    patch "items/:id" =>"items#update"
    resources :genres, only: [:index, :create, :edit,:update]
    # patch "genres/:id" =>"genres#update"
    resources :customers, only: [:index, :show, :edit]
    patch "customers/:id" =>"customers#update"
    resources :orders, only: [:show]
    patch "orders/:id" =>"orders#update"
    patch "order_details/:id" =>"order_details#update"
  end

end
