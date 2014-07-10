Vegan::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  get 'users/auth/:provider' => 'spree/omniauth_callbacks#passthru {:provider=>/facebook|twitter|github|google_oauth2/}'

  resources :tags
  resources :comments

  resources :posts do

    resources :comments

    collection do
      post :get_tag_details
      get :get_latest_blogpost
      get :home#, :as => 'abcd'
    end

  end

  mount Spree::Core::Engine, :at => '/'

  #root to: "spree/user_registrations#new"
  #root to:  "high_voltage/posts#home", :id => '/'
  get '/home' => 'posts#home'



end
