Rails.application.routes.draw do

  

  namespace :webhooks do
    post ':type' => :receive
  end
  
  get 'ui(/:action)', controller: 'ui'
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
