PepCampaigns::Application.routes.draw do
  
  devise_for :admins

  root :to => 'root#index'

  resources :references do
    member do
      get :supply
    end
  end

  namespace :admin do
    root :to => 'root#index'
  end

end
