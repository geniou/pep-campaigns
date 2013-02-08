PepCampaigns::Application.routes.draw do
  
  devise_for :admins

  root :to => 'root#index'

  namespace :admin do
    root :to => 'root#index'
  end

end
