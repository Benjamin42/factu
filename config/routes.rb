Factu::Application.routes.draw do
  
  get "mailing/index"
  match 'mailing/envoi' => 'mailing#envoi', :via => [:get, :post], :as => :search
  match 'mailing/saveBrouillon' => 'mailing#saveBrouillon'
  match 'mailing/saveEnvoi' => 'mailing#saveEnvoi'
  match 'mailing/createDivToPrint' => 'mailing#createDivToPrint'

  resources :cleaning_pays
  match 'cleaning_pays/uploadFile' => 'cleaning_pays#uploadFile'  

  resources :cleaning_villes
  match 'cleaning_villes/uploadFile' => 'cleaning_villes#uploadFile'

  match 'cleaning' => 'cleaning#index'
  match 'cleaning/edit/:id' => 'cleaning#edit'
  match 'cleaning/update/:id' => 'cleaning#update'

  resources :services

  resources :parameters
  resources :types

  resources :fin_de_mois

  resources :bdls
  match 'bdls/new_with_client/:id' => 'bdls#new_with_client'
  match 'bdls/impression/:id' => 'bdls#impression'

  get "commande_stats/index"
  

  match 'cartographie/' => 'cartographie#index'

  resources :commandes 
  #match ':controller(/:action(/:id(.:format)))'
  match 'commandes/bar/:id' => 'commandes#bar'
  match 'commandes/defreeze/:id' => 'commandes#defreeze'

  match 'commandes/uploadFile' => 'commandes#uploadFile'
  match 'commandes/new_with_client/:id' => 'commandes#new_with_client'
  match 'commandes/facturation/:id' => 'commandes#facturation'
  match 'commandes/facturation/facture/:id' => 'commandes#facture'
  
  resources :commande_stats
  
  get "accueil/index"
  root :to => "accueil#index"

  resources :tarifs

  resources :clients
  match 'clients/uploadFile' => 'clients#uploadFile'

  resources :produits
  
  

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
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
