PepCampaigns::Application.routes.draw do
  
  devise_for :admins

  root :to => 'root#index'

  resources :campaigns do
    resources :applications do
      resources :references
    end
  end

  namespace :admin do
    root :to => 'root#index'
  end

end
