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
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
