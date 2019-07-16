Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'

  get 'users/amnesia/:token', to: 'users#amnesia'
  post 'users/amnesia/:token', to: 'users#amnesia' 

  namespace :api, defaults: { format: :json } do
    post 'users/facebook', to: 'users#facebook'    
    devise_for :users    
    resources :pubs do
      collection do
        post 'upload_logo'
        put 'enable_pub'
      end      
    end
    resources :orders do
      get 'client_token', on: :collection
      post 'validate', on: :collection
    end
    resources :drinks do 
      collection do
        put 'enable_drink'
      end
    end
    resources :pub_drinks do 
      collection do
        put 'enable_pub_category'
      end
    end
    resources :users
    resources :drink_categories do
      collection do 
        put 'enable_category'
      end
    end
    resources :gifts
  end

  get 'mobile', to: 'application#index'
  get 'mobile/index', to: 'application#index'  
end
