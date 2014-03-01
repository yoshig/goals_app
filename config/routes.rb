GoalsApp::Application.routes.draw do
  root to: "users#show"
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :comments, only: [:create]
  resources :cheers, only: [:create]
  resources :goals do
    member do
      post "toggle_privacy"
      post "toggle_completion"
    end
  end
end
