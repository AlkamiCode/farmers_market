Rails.application.routes.draw do
  root to: "static_pages#index"

  get "/login",        to: "sessions#new"
  post "/login",       to: "sessions#create"
  delete "/logout",    to: "sessions#destroy"

  get '/stores',      to: "stores#index"
  get '/',            to: "static_pages#index"
  get "/cart",         to: "cart_items#index"
  # Commented out pending how we will use them for unregistered users
  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:show]
  resources :orders, only: [:index, :show]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :addresses, only: [:new, :update, :create]

  namespace :stores, path: "/:store" do
    get "/:store/products", path: "/", to: "products#index"
    resources :products, except: [:create, :update, :destroy, :index]
    resources :categories, except: [:create, :update, :destroy]
  end

  get "/dashboard",    to: "users#show"

  patch "/account",    to: "users#update"
  post "/account",     to: "users#create"
  get "/account/new",  to: "users#new"
  get "/account/edit", to: "users#edit"


  namespace :admin do
    get '/:store/products', to: "stores/products#index"
    resources :stores, as: :store, path: "/:store"
    resources :products
    resources :orders, only: [:index, :show, :update]

    get "/",           to: "admins#index"
    get "/:store/dashboard", as: "/dashboard", path: "/:store/dashboard", param: :slug, to: "admins#index"
  end

  get "/admin/ordered-orders",   to: "admin/orders#index_ordered"
  get "/admin/paid-orders",      to: "admin/orders#index_paid"
  get "/admin/cancelled-orders", to: "admin/orders#index_cancelled"
  get "/admin/completed-orders", to: "admin/orders#index_completed"

  resources :charges

  post "twilio/connect_customer" => "twilio#connect_customer"
end
