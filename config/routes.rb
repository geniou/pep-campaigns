PepCampaigns::Application.routes.draw do
  
  devise_for :admins

  root :to => 'root#index'

  resources :campaigns, :constraints => { :id => /[^\/]+/ } do
    resources :applications, :constraints => { :id => /[^\/]+/ } do
      member do
        get :success
      end
      resources :references, :constraints => { :id => /[^\/]+/ } 
    end
  end

  namespace :admin do
    root :to => 'root#index'

    resources :campaigns
  end

end
