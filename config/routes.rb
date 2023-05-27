Rails.application.routes.draw do
  root to: 'customers#index'
  resources :customers
  resources :orders
  
  get    '/customers/:customer_id/orders',          to: 'orders#index', as: 'customer_orders'
  post   '/customers/:customer_id/orders',          to: 'orders#create'
  get    '/customers/:customer_id/orders/new',      to: 'orders#new',   as: 'new_customer_order'
  get    '/customers/:customer_id/orders/:id',      to: 'orders#show',  as: 'customer_order'
  get    '/customers/:customer_id/orders/:id/edit', to: 'orders#edit',  as: 'edit_customer_order'
  patch  '/customers/:customer_id/orders/:id',      to: 'orders#update'
  delete '/customers/:customer_id/orders/:id',      to: 'orders#destroy'

end
