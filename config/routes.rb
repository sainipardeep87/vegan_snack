Vegan::Application.routes.draw do
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  #  mount Spree::Core::Engine, :at => '/'
  root to: 'spree/user_registrations#new', as: '/'

  #constraints subdomain: false do
  #get ':any', to: redirect(subdomain: 'www', path: '/%{any}'), any: /.*/
  #end

  resources :statics do
    collection do
      get :aboutus
      get :snacks
      get :contactus
      get :faq
      get :membership
      get :snack_detail
      get :individual_product
      get :privacy_policy
      get :term_conditions
    end
  end

  resources :api , except:[:destroy, :edit, :update, :create, :new] do
    collection do
      post :orders_placed
      post :add_shipments
      post :update_shipments
      get  :subscription_charged
      post :subscription_charged
      get  :subscription_charge_error
      post :subscription_charge_error
    end
  end

  mount Spree::Core::Engine, at: '/spree'
  mount Ckeditor::Engine => '/ckeditor'

  resources :users do
    collection do
      get :profile
      post :update_account
      post :update_address
      post :update_password
      post :new_address
      get :new_billing_address
      post :billing_address
      get :edit_address
      post :fetch_address
      post :remove_address
      get :new_acc_address
      post :create_acc_address

      post :pause
      post :resume
    end
  end

  resources :my_subscriptions do
    collection do
      get :create_new_subscription
      get :prompt_cancelation
      get :prompt_confirmation_modal
      #post :pause
      post :resume
      #post :submit_cancel
      post :fetch_subscriptions_payment
      post :unblock
      get :fetch_used_card
    end
    member do
      get :cancel
      post :submit_cancel
      #post :resume
      post :pause
      post :block
    end
  end

  resources :subscriptions do
    collection do
      post :place
    end
  end

  resources :creditcards , except: [:destroy, :edit,  :update, :create, :new] do
    collection do
     post :newcard
      post :confirm_payment
      post :add_card_complete_payment
      post :pay
    end
    member do
      post :update
    end
  end

  resources :cart_items do
    collection do
      post :name
    end
  end

  resources :carts do
    collection do
      post :add
      post :add_snack_to_queue
      get :my_cart
      post :remove_item
      post  :update_cart
      get :update_cart
      post :change_subscription_type
      post :place_subscription
      post :new_subscription
      get :new_cart
      post :get_notification
      post :check_cart_status

    end
  end


  authenticated :users do
    root to: 'sers#profile'
  end

  resources :tags
  resources :comments

  resources :posts,  only: [:index, :show] do
    resources :comments
    collection do
      post :get_tag_details
      get :get_latest_blogpost
    end
  end


  get "/snack_list", to: 'spree/products#snack_list'
  get "/snack_show", to: 'spree/products#snack_show'
  # get "/snack_detail", to: 'spree/products#list_products'

  authenticated :user do
    root to: 'user#show', as: :authenticated_root
  end

  devise_scope :spree_user do
    get 'users/auth/:provider/callback' => 'spree/user_registrations#new_facebook_signup'
    #get 'users/auth/:provider/callback' => 'spree/user_registrations#new'
    post '/fb_auth' => 'spree/user_registrations#create_facebook_auth_user'
    post '/save_newsletter' => 'spree/user_registrations#save_newsletter'
    get '/check_email' => 'spree/user_registrations#check_email'
    get '/wizard_new' => 'spree/user_registrations#wizard_new'
    get '/check_phone_no_format', to: 'spree/user_registrations#check_phone_no_format'
    get :admin, :to => 'spree/user_sessions#new'
  end

  resources :images do
    collection do
      post :image_link
    end
  end


  Spree::Core::Engine.routes.draw do
    resources :orders, except: [:new, :create, :destroy] do
      collection do
        get :snack_queue
        get :update_subscription
        get :my_subscription
        post :change_subscription_type
        post :place_subscription
        post :check_order_completed
        post :order_placed, :to => 'orders#order_placed'
        get :confirm
        post :edit_snack_queue
        post :update_snack_queue
        get :get_card
      end
    end

    resources :products do
      collection do
        post :product_details
        # get :list_products
      end
    end
  end
  Spree::Core::Engine.routes.draw do
    namespace :admin do
      # get '/spree/admin/vendors', to: 'spree/admin/vendors#index', as: 'vendors'

      resources :blogs
      #get '/spree/admin/vendors', to: 'spree/admin/vendors#index'
      # get '/spree/admin/blogs', to: 'spree/admin/blogs#index'
      resources :password
      resources :subscriptions

      resources :coupons do
        collection do
          get :check_valid_coupon
          post :generate_coupon
        end
      end
      resources :orders do
        collection do
          post :export
          get :range
        end

      end
        resources :vendors, as: 'vendors'
    end
  end

end