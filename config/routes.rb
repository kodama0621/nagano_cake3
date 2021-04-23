Rails.application.routes.draw do
  devise_for :customers, skip: :registrations,controllers: {
    sessions:      'public/sessions',
    passwords:     'public/passwords'
  }

  devise_scope :customer do
  get 'customers/sign_up' => 'public/registrations#new', as: :new_customer_registration
  post 'customers' => 'public/registrations#create', as: :customer_registration
  end

  delete 'cart_items/' => 'public/cart_items#alldelete',as: :alldelete
  get 'customers/destroy' => 'public/customers#confirm'
  patch 'customers/destroy' => 'public/customers#destroy'
  post 'orders/confirm' => 'public/orders#confirm',as: :orders_confirm
  get 'orders/complete' => 'public/orders#complete',as: :orders_complete
  root :to => 'public/homes#top'
  get 'about/' => 'public/homes#about'

  scope module: :public do
    resources :items, only: [:index, :show]
    resource :customers, only:[:edit, :show, :update]
    resources :cart_items, only:[:index, :create, :update, :destroy]
    resources :orders, only:[:index, :create, :new, :show]
    resources :addresses, except:[:new, :show]
  end

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admins do
    resources :order_items, only: [:update]
    resources :orders, only:[:show, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, except:[:destroy]
    resources :customers, only:[:index, :show, :edit, :update]
    root :to => 'homes#top', as: 'top'
  end

end