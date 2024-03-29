Rails.application.routes.draw do
  resources :advertises
  resources :catalogs do
    resources :advertises, only: :index do
      member do
        post :attach
        delete :detach
      end
    end
  end
  resources :orders, except: [:update] do
    resources :sales_invoices, only: :index
    resources :delivery_orders, only: :index
    resources :carts, only: [:index, :create]
  end
  resources :addresses, only: [:index]
  resources :customers do
    resources :addresses, except: [:index]
  end
  resources :currencies
  resources :manufactures do
    resources :manifests, only: [:create, :update, :destroy]
  end
  resources :products do
    resources :assemblies, only: [:index, :create, :update, :destroy]
  end
  resources :categories
  resources :providers, except: [:create]
  resources :materials, except: [:create] do
    resources :depreciations, except: [:update]
    resources :purchases, only: [:index]
  end
  resources :purchases, only: [:create]
  resources   :users do
    collection do
      post  :check
      post  :token
      get   :by_role
    end
  end
  scope :charts, controller: 'charts' do
    get :user_by_role
    get :purchasing_growth
  end
end
