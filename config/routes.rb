PepCampaigns::Application.routes.draw do
  
  devise_for :admins

  root :to => 'root#index'

  resources :campaigns, :constraints => { :id => /[^\/]+/ } do
    resources :applications, :constraints => { :id => /[^\/]+/ } do
      member do
        get :success
      end
      resources :references, :constraints => { :id => /[^\/]+/ } do
        member do
          get :success
        end
      end
    end
  end

  namespace :admin do
    root :to => 'campaigns#index'

    resources :campaigns do
      resources :questions
    end

    resources :applications
    resources :references
  end

end
