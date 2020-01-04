Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  get 'ui(/:action)', controller: 'ui'
  get 'privacy', to: "front#privacy"
  
  resources :seo_score, only: [:index] 
  get 'results', to: "seo_score#results"
  
  resources :shops, only: [:show, :destroy, :update] do 
    get 'needs_seo_help', to: 'shops#needs_seo_help'
    resources :keywords, module: :shops 
    resources :tests, module: :shops 
    resources :pages, module: :shops do 
      collection do 
        get 'insights', to: 'pages#insights'
      end
      resources :tests, module: :pages
    end
    resource :recurring_application_charge, only: [:show, :destroy, :create], module: :shops do
      post 'create_subscription', to: 'recurring_application_charge#recurring_application_charge'
      collection do
        get :callback
        post :customize
      end
    end
  end
  
  get 'auth/google_oauth2/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')
  
  get 'select_website', to: 'search_console#select_website'
  get 'downloading_data', to: 'search_console#downloading_data'
  
  resources :charts do 
    collection do 
      get "branded", to: "charts#branded"
      get 'longtail', to: "charts#longtail"
      get 'transactional', to: "charts#transactional"
    end
  end
  
  get 'sign_in', to: "session#new"
  get 'sign_out', to: 'session#destroy'
  resources :session, only: [:create]
  
  namespace :admin do 
    resources :tests 
    resources :shops do 
      collection do 
        get 'delete_everything', to: 'shops#delete_everything'
      end
      get 'reset_gsc', to: 'shops#reset_gsc'
      get 'delete_gsc', to: 'shops#delete_gsc'
      resources :pages, module: :shops do 
        resources :tests, module: :pages
      end
    end
  end
  
  controller :mandatory_webhooks do
    post '/webhooks/shop_redact' => :shop_redact
    post '/webhooks/customers_redact' => :customers_redact
    post '/webhooks/customers_data_request' => :customers_data_request
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
