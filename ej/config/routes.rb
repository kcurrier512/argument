Rails.application.routes.draw do
<<<<<<< HEAD
get 'posts/:id/analyze' => 'posts#analyze', as: 'analyze'
  resources :drafts do
    get :autocomplete_tag_name, :on => :collection
  end
=======
  match 'posts/:id/diff' => 'posts#diff', as: 'diff', via: [:get, :post]
  get 'posts/:id/analyze' => 'posts#analyze', as: 'analyze'
  resources :drafts
>>>>>>> difffunction
  resources :footnotes
  resources :annotations
  get 'evaluations/index'
  post 'evaluations/save_rankings'
  resources :evaluations do
    post :update_row_order, on: :collection
  end
  resources :assigned_positions
  resources :memberships
  resources :groups
  mount Ckeditor::Engine => '/ckeditor'
  get 'posts/inclass' => 'posts#inclass'
  get 'posts/myposts' => 'posts#myposts'
  resources :likes
  resources :notes
  resources :posts
  resources :comments
  resources :positions
  resources :assignments
  get 'home/index'
  get '/stats' => 'home#stats'
  get '/help' => 'home#help'
  get '/photojour' => 'home#photojour'




  resources :posts do

    member do
        get :flop
        post :flop
    end
  end


  root to:"home#index"

  devise_for :users
  resources :users, only: [:index]
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
  #     resources :products
  #   end
end
