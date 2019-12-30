Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  get 'ui(/:action)', controller: 'ui'
  
  resources :shops, only: [:show, :destroy, :update] do 
    resources :pages, module: :shops do 
      collection do 
        get 'insights', to: 'pages#insights'
      end
      resources :tests, module: :pages
    end
  end
  
  get 'auth/google_oauth2/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')
  
  get 'select_website', to: 'search_console#select_website'
  get 'downloading_data', to: 'search_console#downloading_data'
  
  namespace :admin do 
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
