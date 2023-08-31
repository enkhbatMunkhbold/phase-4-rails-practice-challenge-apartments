Rails.application.routes.draw do
  resources :leases, only: [:index, :show, :create, :destroy, :update]
  resources :tenants, only: [:index, :show, :create, :destroy, :update]
  resources :apartments, only: [:index, :show, :create, :destroy, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
