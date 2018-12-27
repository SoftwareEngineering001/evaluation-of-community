Rails.application.routes.draw do


  get 'teachers/new'

  root 'comments#index'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'home' => 'static_pages#home'
  get 'rules' => 'static_pages#rules'
  get 'setup' => 'static_pages#setup'
  ##
  get 'update' => 'users#update'
  ##
  get 'search' => 'basics#search'
  # post 'search' => 'basics#search'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  #get 'comments' => 'comments#index'
  #post 'comment' => 'comment#create'
  post 'upload_courses' => 'courses#upload'
  
  post 'follow_attitudes' => 'attitudes#follow'
  post 'unfollow_attitudes' => 'attitudes#unfollow'
  post 'recom_attitudes' => 'attitudes#recom'
  post 'unrecom_attitudes' => 'attitudes#unrecom'
  post 'disrecom_attitudes' => 'attitudes#disrecom'
  post 'undisrecom_attitudes' => 'attitudes#undisrecom'
  post 'learn_attitudes' => 'attitudes#learn'
  post 'unlearn_attitudes' => 'attitudes#unlearn'
  post 'approve_attitudes' => 'attitudes#approve'
  post 'unapprove_attitudes' => 'attitudes#unapprove'
  
  post 'save_course_info_courses' => 'courses#save_course_info'
  post 'save_teacher_info_teachers' => 'teachers#save_teacher_info'
  get   'notify' => 'users#notify'
  resources :comments, only: [:new, :create, :index, :destroy]
  resources :users 
  # resources :static_pages 
  resources :courses
  resources :relationships,       only: [:create, :destroy]
  resources :interest_courses,       only: [:create, :destroy]
  resources :rates
  resources :teachers
  resources :teachers do
    member do
      get :edit_profile, :profile_history
    end
  end
  
  resources :courses do
    member do
      get :editcourse
    end
  end
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
