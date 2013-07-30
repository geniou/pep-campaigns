PepCampaigns::Application.routes.draw do

  devise_for :admins

  root to: 'root#index'

  resources :campaigns, constraints: { id: /[^\/]+/ } do
    resources :applications, constraints: { id: /[^\/]+/ } do
      member do
        get :success
      end
      resources :references, constraints: { id: /[^\/]+/ } do
        member do
          get :success
        end
      end
    end
  end

  resources :summaries

  namespace :admin do
    root to: 'campaigns#index'

    resources :campaigns, constraints: { id: /[^\/]+/ } do
      get :export
      resources :questions
    end
    resources :applications do
      get :export
      get :summary
    end
    resources :references
    resources :contacts
    resources :answers do
      put :hide_on_summary
      put :show_on_summary
    end
  end
end
