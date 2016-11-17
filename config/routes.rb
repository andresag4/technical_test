Rails.application.routes.draw do
  resources :products, except: [:show]

  # Get the cart view.
  get '/cart', to: 'cart#index', as: :get_cart

  # Adds a product to the cart.
  match '/add/:product_id', to: 'cart#add', as: :add_product, via: [:patch, :put]

  # Removes one element of the product from the cart.
  match '/remove/:product_id', to: 'cart#remove', as: :remove_product, via: [:patch, :put]

  # Removes the product from the cart.
  match '/remove_all/:product_id', to: 'cart#remove_all', as: :remove_all_product, via: [:patch, :put]

  # Gets a new row for the cart.
  get '/get_row/:product_id', to: 'cart#get_row', as: :get_row

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     #   end
end
