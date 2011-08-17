ActionController::Routing::Routes.draw do |map|
  map.resources :localities
  map.resources :samples
  map.resources :uploads, :collection => {:morphbank => :get}, :member => {:morphbank_import => :get}

  map.resources :morphbanks do |mb|
    mb.resources :species, :member => {:link_to_morphbank => :get}
  end
  map.resources :morphbanks, :member => {:from_file => :get, :attempt_resolve => :get}, :collection => {:search_morphbank => :get}

  map.root :controller => "pages"
  map.resources :species do |species|
    species.resources :morphbanks, :collection => {:search_from_species => :get }, :member => {:link_to_species => :get}
    species.resources :versions, :member => {:show => :get }
  end
  map.resources :species, :collection => {:search => :get}
  
  map.resources :speciesversions, :belongs_to => :species, :member => {:approve => :get}
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil

  map.connect '/species/filter/:field/:id', :controller => :species, :action => :filter
  
  map.resources :synonyms, :has_many => :versions
  map.resources :synonymversions, :belongs_to => :synonyms, :member => { :approve => :get }
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
 

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
