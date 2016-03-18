Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.

  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  root 'users#index'

  resources :users, :only => [:create, :new, :index, :show, :destroy]
  resources :api_keys, :only => [:create, :new, :index, :destroy]

  #get 'keys' => 'api_keys#show', as: :keys

  get   'allusers'   => 'users#show', as: :allusers
  post  'login'   => 'users#login', as: :login
  get   'logout'  => 'users#logout', as: :logout

  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/test" => 'sessions#test'
  get "/authenticate" => "sessions#authenticate"
  get "/unauthorized" => "sessions#unauthorized", :as => :unauthorized
  get "/unauthorized_key" => "sessions#unauthorized_key", :as => :unauthorized_key

  get '/api/v1/games/tag/:id' => 'api/v1/games#tag', :as => :games_tag
  
  get '/api/v1/games/search_for/:team_id' => 'api/v1/games#search_for', :as => :games_search_for
  
  post '/api/v1/games/:id/tag/:tag_id' => 'api/v1/games#add_tag', :as => :games_add_tag
  delete '/api/v1/games/:id/tag/:tag_id' => 'api/v1/games#remove_tag', :as => :games_remove_tag
  
  match '*any' => 'application#options', :via => [:options]

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :games
      resources :locations
      resources :tags
      resources :teams

      root to: 'games#index'

    end
  end


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
  #     resources :products
  #   end
end
