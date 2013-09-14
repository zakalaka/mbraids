Mbraids::Application.routes.draw do

  #get "user_images/create"
  #
  #get "user_images/destroy"

  #resources :line_items
  #match 'line_items'

  root :to => 'application#index'

  match 'auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {:registrations => 'registrations'} #, :path_name => {:sign_up => "register"} #this is to change the default
  resources :authentications

                                                                         #match ':locale/images/:name.:format' => redirect("/images/%{name}.%{format}")


  scope "(:locale)", :locale => /en|ru/ do
    match 'ladies' => 'hairstyle_collections#ladies'
    match 'girls' => 'hairstyle_collections#girls'
    resources :hairstyle_collections do
      #match 'hairstyles/:locale' => 'hairstyles#index'
      #match ':locale/hairstyles/create' =>
      resources :hairstyles
    end
  end

                                                                         #TODO: i18n
                                                                         #scope "(:locale)", :shallow_path => "(:locale)", :locale => /en|ru/ do
  scope "(:locale)", :locale => /en|ru/ do
    match 'accessories' => 'categories#index'
    match 'book_appointment' => 'appointments#book'
    resources :accessories, :except => :index
    resources :appointments
    resources :categories do
      resources :accessories
    end
    resources :accounts
    resources :orders
    #resources :hairstyles
    #resources :hairstyle_collections, :shallow => true do
    #  #match ':locale/hairstyles' => 'hairstyle_collections#index'
    #  resources :hairstyles
    #end
    resource :quote_box do
      #post 'line_items'
      resources :line_items
    end
    match 'attach_image' => 'orders#add_image', :via => [:post]
    match 'portfolio' => 'hairstyle_collections#index'
  end
                                                                         #resources :authentications
                                                                         # The priority is based upon order of creation:
                                                                         # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/_index.html.
  #TODO: change this!
  match '/:locale' => 'application#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
